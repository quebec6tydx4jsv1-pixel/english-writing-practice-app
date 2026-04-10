FactoryBot.define do
  factory :review_answer do
    review_answer_text { Faker::Lorem.sentence }
    association :review_question
    association :user
  end
end
