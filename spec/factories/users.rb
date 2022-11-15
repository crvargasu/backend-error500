# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email    { Faker::Internet.unique.email }
    password { Faker::Number.number(digits: 10).to_s }
  end
end
