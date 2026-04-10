FactoryBot.define do
  factory :review_question do
    question_text { Faker::Lorem.sentence }
    association :user_weak_expression
  end
end
