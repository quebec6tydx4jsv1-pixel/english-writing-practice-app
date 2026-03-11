class Question < ApplicationRecord
  belongs_to :theme
  has_many :user_answers
end
