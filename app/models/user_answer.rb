class UserAnswer < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :question
  has_one :ai_correction, as: :correctable, dependent: :destroy
end
