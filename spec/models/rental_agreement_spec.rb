require 'rails_helper'

RSpec.describe RentalAgreement, type: :model do
  describe 'Attributes' do
    it { should respond_to :timestamp_start }
    it { should respond_to :timestamp_end }
    it { should respond_to :status }
    it { should respond_to :lessor_id }
    it { should respond_to :leaseholder_id }
  end

  describe 'Associations' do
    it { should belong_to(:leaseholder) }
    it { should belong_to(:lessor) }
  end
end
