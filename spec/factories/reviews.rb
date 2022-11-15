# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    leaseholder { create(:leaseholder) }
  end
end
