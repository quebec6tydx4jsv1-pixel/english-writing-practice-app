FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { "password123" }
    admin { false }
    daily_api_count { 0 }
    monthly_api_count { 0 }

    trait :admin do
      admin { true }
    end
  end
end
