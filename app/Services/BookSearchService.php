<?php

declare(strict_types=1);

namespace App\Services;

use App\Models\Book;
use Illuminate\Database\Eloquent\Builder;

/**
 * Relevance-ranked book search.
 *
 * Turns a natural-language query into a scored, filtered Eloquent query:
 * tokenize → strip stopwords → expand domain synonyms → match across weighted
 * fields, then blend in rating quality, availability and popularity to produce
 * a single "Best match" score. All scoring is portable SQL (LIKE + CASE +
 * correlated subqueries) so it behaves identically on MySQL and SQLite.
 */
class BookSearchService
{
    /** Approved-average rating for the current book row. */
    private const AVG_SUB = '(SELECT COALESCE(AVG(r.rating), 0) FROM ratings r WHERE r.book_id = books.id AND r.is_approved = 1)';

    /** Count of approved ratings for the current book row. */
    private const RATING_COUNT_SUB = '(SELECT COUNT(*) FROM ratings r WHERE r.book_id = books.id AND r.is_approved = 1)';

    /** Total borrows for the current book row. */
    private const BORROW_COUNT_SUB = '(SELECT COUNT(*) FROM borrows b WHERE b.book_id = books.id)';

    /** Genre name for the current book row. */
    private const GENRE_NAME_SUB = '(SELECT g.name FROM genres g WHERE g.id = books.genre_id)';

    /** Text columns matched for both scoring and the relevance gate. */
    private const TEXT_FIELDS = ['title', 'author', 'description', 'publisher'];

    /**
     * Build a relevance-ranked, filtered book query ready to paginate.
     *
     * @param  array{
     *     q?: string|null, genre?: string|int|null, minRating?: int|null,
     *     yearFrom?: int|string|null, yearTo?: int|string|null,
     *     availableOnly?: bool, sort?: string|null
     * }  $params
     */
    public function query(array $params = []): Builder
    {
        $phrases = $this->phrases((string) ($params['q'] ?? ''));
        $genre = (string) ($params['genre'] ?? '');
        $minRating = (int) ($params['minRating'] ?? 0);
        $yearFrom = $params['yearFrom'] ?? null;
        $yearTo = $params['yearTo'] ?? null;
        $availableOnly = (bool) ($params['availableOnly'] ?? false);
        $sort = (string) ($params['sort'] ?? 'relevance');

        [$scoreSql, $scoreBindings] = $this->scoreExpression($phrases);

        $builder = Book::query()
            ->select('books.*')
            ->selectRaw("$scoreSql as relevance_score", $scoreBindings)
            ->with('genre')
            ->withAvg(['ratings as avg_rating' => fn ($q) => $q->where('is_approved', true)], 'rating')
            ->withCount(['ratings as approved_count' => fn ($q) => $q->where('is_approved', true)])
            ->withCount(['borrows as borrow_count']);

        // Relevance gate: with a query present, a book must match at least one
        // text field — quality/popularity only re-rank genuine matches.
        if ($phrases !== []) {
            [$gateSql, $gateBindings] = $this->textMatchClause($phrases);
            $builder->whereRaw($gateSql, $gateBindings);
        }

        $builder
            ->when($genre !== '', fn (Builder $q) => $q->where('genre_id', $genre))
            ->when($minRating > 0, fn (Builder $q) => $q->whereRaw(self::AVG_SUB.' >= ?', [$minRating]))
            ->when($yearFrom !== null && $yearFrom !== '', fn (Builder $q) => $q->where('published_year', '>=', (int) $yearFrom))
            ->when($yearTo !== null && $yearTo !== '', fn (Builder $q) => $q->where('published_year', '<=', (int) $yearTo))
            ->when($availableOnly, fn (Builder $q) => $q->where('available_copies', '>', 0));

        $this->applySort($builder, $sort, $phrases !== []);

        return $builder;
    }

    /**
     * Reduce a raw query to the distinct search phrases used for matching:
     * lower-cased tokens (≥ 2 chars, stopwords removed) plus their synonyms.
     *
     * @return list<string>
     */
    public function phrases(string $query): array
    {
        $query = trim($query);

        if ($query === '') {
            return [];
        }

        $stopwords = config('search.stopwords', []);
        $synonyms = config('search.synonyms', []);

        $tokens = preg_split('/[^\p{L}\p{N}]+/u', mb_strtolower($query), -1, PREG_SPLIT_NO_EMPTY) ?: [];

        $phrases = [];

        foreach ($tokens as $token) {
            if (mb_strlen($token) < 2 || in_array($token, $stopwords, true)) {
                continue;
            }

            $phrases[] = $token;

            foreach ($synonyms[$token] ?? [] as $synonym) {
                $phrases[] = mb_strtolower($synonym);
            }
        }

        return array_values(array_unique($phrases));
    }

    /**
     * Human-readable list of which fields a result matched, for the "why this
     * matched" hint. Pure PHP — no extra query.
     *
     * @param  list<string>  $phrases
     * @return list<string>
     */
    public function matchedFields(Book $book, array $phrases): array
    {
        if ($phrases === []) {
            return [];
        }

        $haystacks = [
            'Title' => $book->title,
            'Author' => $book->author,
            'Genre' => $book->genre?->name,
            'Description' => $book->description,
            'Publisher' => $book->publisher,
        ];

        $matched = [];

        foreach ($haystacks as $label => $value) {
            if ($value === null || $value === '') {
                continue;
            }

            $lower = mb_strtolower((string) $value);

            foreach ($phrases as $phrase) {
                if (str_contains($lower, $phrase)) {
                    $matched[] = $label;
                    break;
                }
            }
        }

        return $matched;
    }

    /**
     * Composite "Best match" score expression and its bindings.
     *
     * @param  list<string>  $phrases
     * @return array{0: string, 1: list<string>}
     */
    private function scoreExpression(array $phrases): array
    {
        $weights = config('search.weights');
        $caps = config('search.caps');

        $parts = [];
        $bindings = [];

        foreach ($phrases as $phrase) {
            $like = '%'.$phrase.'%';

            foreach (self::TEXT_FIELDS as $field) {
                $parts[] = "CASE WHEN books.$field LIKE ? THEN {$this->num($weights[$field])} ELSE 0 END";
                $bindings[] = $like;
            }

            $parts[] = 'CASE WHEN '.self::GENRE_NAME_SUB." LIKE ? THEN {$this->num($weights['genre'])} ELSE 0 END";
            $bindings[] = $like;
        }

        // Rating quality: approved average × weight (0–5 points).
        $parts[] = self::AVG_SUB.' * '.$this->num($weights['rating']);

        // Availability: flat in-stock boost + a small per-copy bump (capped).
        $parts[] = "CASE WHEN books.available_copies > 0 THEN {$this->num($weights['available'])} ELSE 0 END";
        $parts[] = $this->cappedTerm('books.available_copies', $caps['available_copy'], $weights['available_copy']);

        // Popularity: approved ratings + borrows, each capped.
        $parts[] = $this->cappedTerm(self::RATING_COUNT_SUB, $caps['rating_count'], $weights['rating_count']);
        $parts[] = $this->cappedTerm(self::BORROW_COUNT_SUB, $caps['borrow_count'], $weights['borrow_count']);

        return ['('.implode(' + ', $parts).')', $bindings];
    }

    /**
     * The relevance gate: at least one phrase must match a text field.
     *
     * @param  list<string>  $phrases
     * @return array{0: string, 1: list<string>}
     */
    private function textMatchClause(array $phrases): array
    {
        $clauses = [];
        $bindings = [];

        foreach ($phrases as $phrase) {
            $like = '%'.$phrase.'%';

            foreach (self::TEXT_FIELDS as $field) {
                $clauses[] = "books.$field LIKE ?";
                $bindings[] = $like;
            }

            $clauses[] = self::GENRE_NAME_SUB.' LIKE ?';
            $bindings[] = $like;
        }

        return ['('.implode(' OR ', $clauses).')', $bindings];
    }

    private function applySort(Builder $builder, string $sort, bool $hasQuery): void
    {
        match ($sort) {
            'rating' => $builder->orderByRaw(self::AVG_SUB.' DESC'),
            'popular' => $builder->orderByRaw('('.self::RATING_COUNT_SUB.' + '.self::BORROW_COUNT_SUB.') DESC'),
            'title' => $builder->orderBy('title'),
            'newest' => $builder->latest(),
            default => $hasQuery
                ? $builder->orderByDesc('relevance_score')->orderByRaw(self::AVG_SUB.' DESC')
                : $builder->latest(),
        };

        // Deterministic tiebreak so paginated ordering is stable.
        $builder->orderBy('books.id', 'desc');
    }

    /** "value capped at $cap, times $weight" — portable (no LEAST/MIN). */
    private function cappedTerm(string $expression, int $cap, int|float $weight): string
    {
        return "(CASE WHEN $expression > $cap THEN $cap ELSE $expression END) * ".$this->num($weight);
    }

    /** Render a config weight as a locale-safe SQL numeric literal. */
    private function num(int|float $value): string
    {
        return rtrim(rtrim(sprintf('%.4F', (float) $value), '0'), '.');
    }
}
