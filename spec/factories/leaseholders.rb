FactoryBot.define do
  factory :leaseholder do
    property_account { 'MyString' }
    description { 'MyString' }
    capacity { '10' }
    highlimit { '9.99' }
    area { '9.99' }
    user { create(:user) }
  end
end
