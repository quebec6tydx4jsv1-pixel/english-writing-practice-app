class ReviewQuestion < ApplicationRecord
  belongs_to :user_weak_expression

  has_many :review_answers
end
