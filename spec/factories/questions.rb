FactoryBot.define do
  factory :question do
    input_theme { Faker::Lorem.word }
    input_situation { Faker::Lorem.sentence }
    text { Faker::Lorem.sentence }
    source { "ai" }
  end
end
