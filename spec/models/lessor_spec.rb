require 'rails_helper'

RSpec.describe Lessor, type: :model do
  describe 'Attributes' do
    it { should respond_to :credit }
    it { should respond_to :mean_reviews }
    it { should respond_to :mean_reviews }
    it { should respond_to :user_id }
  end

  describe 'Associations' do
    it { should belong_to(:user) }
    it { should have_many(:rental_agreements) }
  end
end
