FactoryBot.define do
  factory :user_weak_expression do
    note { Faker::Lorem.sentence }
    association :user
    association :mistake
  end
end
