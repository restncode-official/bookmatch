<?php

declare(strict_types=1);

return [

    /*
    |--------------------------------------------------------------------------
    | Advanced search relevance weights
    |--------------------------------------------------------------------------
    |
    | These tune the composite "Best match" score computed by
    | App\Services\BookSearchService. Text weights are added once per matched
    | query phrase, per field; the rating / availability / popularity weights
    | are added once per book. Tune here without touching the query code.
    |
    */

    'weights' => [
        // Text-match weight per matched phrase, by field (higher = more relevant).
        'title' => 10,
        'author' => 5,
        'genre' => 4,
        'description' => 2,
        'publisher' => 1,

        // Quality / availability / popularity (added once per book).
        'rating' => 1.0,  // multiplied by the approved-average (0–5).
        'available' => 3,    // flat boost when at least one copy is in stock.
        'available_copy' => 0.2,  // per available copy, capped below.
        'rating_count' => 0.3,  // per approved rating, capped below.
        'borrow_count' => 0.2,  // per borrow, capped below.
    ],

    // Upper bounds so a few wildly-popular books can't drown out relevance.
    'caps' => [
        'available_copy' => 5,
        'rating_count' => 10,
        'borrow_count' => 15,
    ],

    /*
    |--------------------------------------------------------------------------
    | Stopwords
    |--------------------------------------------------------------------------
    |
    | Filler words stripped from a query before matching, so conversational
    | searches like "tell me the best books that help understand AI" reduce to
    | the meaningful tokens ("ai"). Compared lower-cased.
    |
    */

    'stopwords' => [
        'a', 'an', 'and', 'the', 'to', 'of', 'for', 'in', 'on', 'with', 'about',
        'best', 'good', 'great', 'top', 'better', 'book', 'books', 'novel',
        'read', 'reading', 'which', 'that', 'this', 'these', 'those', 'help',
        'helps', 'understand', 'understanding', 'learn', 'learning', 'tell',
        'me', 'show', 'find', 'want', 'need', 'some', 'any', 'all', 'how',
        'what', 'is', 'are', 'be', 'i', 'my', 'please', 'recommend',
        'recommended', 'recommendation', 'related', 'into', 'get', 'getting',
    ],

    /*
    |--------------------------------------------------------------------------
    | Domain synonyms
    |--------------------------------------------------------------------------
    |
    | After stopword removal, each surviving token is also matched against the
    | extra phrases listed here. Lets "NLP" hit a description that says
    | "natural language processing", "AI" hit "artificial intelligence", etc.
    | Keys are lower-cased tokens; values are additional phrases to OR in.
    |
    */

    'synonyms' => [
        'ai' => ['artificial intelligence'],
        'ml' => ['machine learning'],
        'nlp' => ['natural language processing'],
        'dl' => ['deep learning'],
        'cv' => ['computer vision'],
        'llm' => ['large language model', 'large language models'],
        'os' => ['operating system', 'operating systems'],
        'db' => ['database', 'databases'],
        'oop' => ['object oriented programming', 'object-oriented'],
        'js' => ['javascript'],
        'ts' => ['typescript'],
        'ds' => ['data science', 'data structures'],
        'algo' => ['algorithm', 'algorithms'],
        'ux' => ['user experience'],
        'ui' => ['user interface'],
        'sql' => ['structured query language'],
        'sec' => ['security'],
    ],

];
