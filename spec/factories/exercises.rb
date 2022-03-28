# frozen_string_literal: true

FactoryBot.define do
  factory :exercise do
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence(word_count: 3, supplemental: true) }
    intensity { Faker::Number.between(from: 1, to: 10) }
  end
end
