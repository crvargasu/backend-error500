require 'rails_helper'

RSpec.describe Leaseholder, type: :model do
  describe 'Attributes' do
    it { should respond_to :property_account }
    it { should respond_to :polygon }
    it { should respond_to :mean_reviews }
    it { should respond_to :credit }
    it { should respond_to :status }
    it { should respond_to :id_picture_front }
    it { should respond_to :id_picture_back }
    it { should respond_to :user_id }
  end

  describe 'Associations' do
    it { should belong_to(:user) }
    it { should have_many(:reviews) }
    it { should have_many(:rental_agreements) }
  end
end
