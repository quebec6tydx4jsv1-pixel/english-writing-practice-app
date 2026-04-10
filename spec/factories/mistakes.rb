FactoryBot.define do
  factory :mistake do
    expression_text { Faker::Lorem.word }
    category { "語彙" }
    reason { Faker::Lorem.sentence }
    association :ai_correction
  end
end
