class Mistake < ApplicationRecord
  belongs_to :ai_correction
  has_many :user_weak_expressions, dependent: :destroy
end
