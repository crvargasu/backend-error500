FactoryBot.define do
  factory :review do
    leaseholder { create(:leaseholder) }
  end
end
