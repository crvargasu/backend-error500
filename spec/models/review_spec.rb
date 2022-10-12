require 'rails_helper'

RSpec.describe Api::V1::Review, type: :model do
  describe 'Attributes' do
    it { should respond_to :score }
    it { should respond_to :comment }
    it { should respond_to :api_v1_leaseholders_id }
  end

  describe 'Associations' do
    # it { should belong_to(:leaseholder) }
  end
end
