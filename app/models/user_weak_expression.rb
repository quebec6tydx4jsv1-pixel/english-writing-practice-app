class UserWeakExpression < ApplicationRecord
  belongs_to :user
  belongs_to :mistake
end
