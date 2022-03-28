# frozen_string_literal: true

FactoryBot.define do
  factory :workout do
    name { Faker::Lorem.word }
  end
end
