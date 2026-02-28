class Theme < ApplicationRecord
    has_many :questions, dependent: :destroy
end
