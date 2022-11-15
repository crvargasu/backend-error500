# frozen_string_literal: true

FactoryBot.define do
  factory :rental_agreement do
    lessor { create(:lessor) }
    leaseholder { create(:leaseholder) }
  end
end
