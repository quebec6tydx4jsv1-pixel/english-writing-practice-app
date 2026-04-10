FactoryBot.define do
  factory :user_answer do
    answer_text { Faker::Lorem.sentence }
    association :question
    association :user
  end
end
