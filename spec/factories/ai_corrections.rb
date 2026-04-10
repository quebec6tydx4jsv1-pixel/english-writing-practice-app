FactoryBot.define do
  factory :ai_correction do
    corrected_text { Faker::Lorem.sentence }
    score { rand(60..100) }
    feedback_json { { comments: [Faker::Lorem.sentence] } }
    association :correctable, factory: :user_answer
  end
end
