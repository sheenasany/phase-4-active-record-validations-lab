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
    # .none? returns true if none of the objects in enumerable/array matches the condition, else it returns false
    # compares all the elements with the pattern and returns true if none of them matches with the pattern.
    # in this case, we use .match to check if the pattern matches the title
end
end
