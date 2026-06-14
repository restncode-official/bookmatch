<?php

declare(strict_types=1);

namespace Database\Seeders;

use App\Enums\UserRole;
use App\Models\Book;
use App\Models\Rating;
use App\Models\User;
use Illuminate\Database\Seeder;

class BookReviewsSeeder extends Seeder
{
    /** @var array<int, list<string>> */
    private array $messages = [
        1 => [
            "I couldn't get past the first few chapters. The writing felt disjointed and the characters were completely one-dimensional.",
            "Extremely disappointing. The premise sounded interesting but the execution was poor. I would not recommend this to anyone.",
            "The plot had so many holes that I lost track of what was happening. The author seems to have given up halfway through.",
            "Poorly structured and badly edited. It reads like a rough first draft that was never properly revised.",
            "I regret spending time on this. The story went nowhere and the dialogue felt completely unnatural.",
            "The main characters had no depth whatsoever. I found it impossible to connect with anyone in this story.",
            "Tedious from start to finish. The pacing was painfully slow and there was no payoff at the end.",
            "A major letdown. The description on the back cover bore little resemblance to what was actually inside.",
            "I've rarely struggled through a book like this. The prose was clunky and the narrative had no direction.",
            "Not worth the read. The arguments are poorly supported and the author never backs up the key claims.",
        ],
        2 => [
            "Had an interesting concept but the writing style made it hard to stay engaged. Finished it out of stubbornness.",
            "Some decent ideas scattered throughout but never fully developed. Overall a frustrating read.",
            "The first half was decent but it really fell apart toward the end. The conclusion was particularly weak.",
            "I can see what the author was trying to do, but it didn't quite come together. Needs significant rework.",
            "A few memorable moments saved it from being a total disappointment, but not enough to recommend.",
            "The story started well but lost momentum quickly. By the midpoint I was reading out of obligation.",
            "Mediocre at best. The writing has occasional flashes of quality but they're too infrequent to save the book.",
            "I wanted to like this much more than I did. The execution simply didn't live up to the potential.",
            "Too many subplots that went nowhere. The author spread the narrative too thin.",
            "Some interesting research but the writing style is dry and the organisation could be much better.",
        ],
        3 => [
            "A solid read, nothing groundbreaking. The characters are likable enough and the story moves at a reasonable pace.",
            "Enjoyable but forgettable. I read it over a weekend and had a pleasant enough time, but it won't stay with me long.",
            "A competent book that does what it sets out to do without really exceeding expectations.",
            "Good in stretches but uneven overall. Worth picking up if the subject genuinely interests you.",
            "I had mixed feelings throughout. There are some genuinely engaging chapters alongside some that really drag.",
            "A decent introduction to the subject. Not the most authoritative source but a reasonable starting point.",
            "An average read. Fans of the genre will probably enjoy it more than I did.",
            "The writing is clean and readable but the story lacks any real depth or originality.",
            "It was fine. I can see why others enjoy it, but it didn't resonate with me personally.",
            "Neither bad nor particularly great. A comfortable read for when you want something undemanding.",
        ],
        4 => [
            "A genuinely compelling read. The characters felt real and I found myself thinking about them long after finishing.",
            "Really well written with a plot that kept me guessing. I'd have given it five stars if the ending had been a bit stronger.",
            "Thoroughly enjoyed this. The author has a gift for building tension and the dialogue crackles with energy.",
            "One of the better books I've picked up this year. Highly recommended, especially for those new to the topic.",
            "Impressive depth and very well researched. A few pacing issues in the middle but overall an excellent read.",
            "Engaging from the first page. The world-building is meticulous and the characters are layered and believable.",
            "A very strong book. The author handles complex themes with real nuance and the narrative never loses focus.",
            "Smart, entertaining, and thought-provoking. I'll be recommending this to everyone in my study group.",
            "Beautifully written with some genuinely moving passages. Docking one star only for the slow opening chapters.",
            "This exceeded my expectations in almost every way. The plot twists felt earned and the ending was satisfying.",
        ],
        5 => [
            "An absolute masterpiece. I haven't been so absorbed in a book in years. Finished it in one sitting.",
            "Flawlessly written and profoundly moving. This is the kind of book that changes the way you see the world.",
            "Everything about this was perfect — the pacing, the characters, the prose. I cannot recommend it highly enough.",
            "One of the most important books I've read. Every student in this field should have this on their shelf.",
            "I was completely captivated from start to finish. The author's voice is unique, confident, and utterly compelling.",
            "A rare achievement. The characters felt like real people and I was genuinely devastated when it ended.",
            "Exceptional in every respect. The research is thorough, the arguments are airtight, and it is a pleasure to read.",
            "This book blew me away. I went in with moderate expectations and came out with a new favourite author.",
            "Brilliant storytelling paired with deep, thoughtful insights. A genuinely life-changing read.",
            "Pure five stars without hesitation. I've already recommended it to three friends. Essential reading.",
        ],
    ];

    public function run(): void
    {
        $books = Book::all();
        $users = User::whereIn('role', [UserRole::Student->value, UserRole::Faculty->value])->get();

        foreach ($books as $book) {
            $count = rand(2, min(10, $users->count()));
            $reviewers = $users->random($count);

            foreach ($reviewers as $user) {
                $star = rand(1, 5);

                Rating::create([
                    'user_id'     => $user->id,
                    'book_id'     => $book->id,
                    'rating'      => $star,
                    'message'     => $this->messages[$star][array_rand($this->messages[$star])],
                    'is_approved' => true,
                ]);
            }
        }
    }
}
