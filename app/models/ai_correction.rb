class AiCorrection < ApplicationRecord
  belongs_to :user_answer
  has_many :mistakes, dependent: :destroy
end
