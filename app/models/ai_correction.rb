class AiCorrection < ApplicationRecord
  # belongs_to :user_answer
  belongs_to :correctable, polymorphic: true
  has_many :mistakes, dependent: :destroy
end
