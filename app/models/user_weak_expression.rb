class UserWeakExpression < ApplicationRecord
  belongs_to :user
  belongs_to :mistake
  has_many :review_questions, dependent: :destroy
end
