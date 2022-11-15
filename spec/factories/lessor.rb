FactoryBot.define do
  factory :lessor do
    credit { '30' }
    mean_reviews { '2' }
    user { create(:user) }
  end
end
