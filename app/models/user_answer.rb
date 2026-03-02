class UserAnswer < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :question
  has_one :ai_correction, dependent: :destroy
end
