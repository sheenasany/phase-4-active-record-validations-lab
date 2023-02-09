class Post < ApplicationRecord

validates :title, presence: true, on: :create
validates :title, presence: true, on: :update, if: :sufficiently_clickbait_y
validates :content, length: { minimum: 250}
validates :summary, length: { maximum: 250}
validates :category, inclusion: { in: %w(Fiction Non-Fiction) }
validate :sufficiently_clickbait_y

CLICKBAIT_PATTERNS = [
    /Won't Believe/i,
    /Secret/i,
    /Top \d/i,
    /Guess/i
]
# /i = not case sensitive
# \d = includes a number

def sufficiently_clickbait_y
    if CLICKBAIT_PATTERNS.none? { |pat| pat.match title }
        errors.add(:title, "requires clickbait-y title")
    end

    # unless title != "Won't Believe" || "Secret" || "Top[number]" || "Guess"
    #     errors.add(:title, "requires clickbait-y title")
    # end
end
end
