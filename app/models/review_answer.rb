class ReviewAnswer < ApplicationRecord
  belongs_to :user
  belongs_to :review_question
end
