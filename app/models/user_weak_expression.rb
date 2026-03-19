class UserWeakExpression < ApplicationRecord
  belongs_to :user
  belongs_to :mistake
  has_one :review_question, dependent: :destroy
end
