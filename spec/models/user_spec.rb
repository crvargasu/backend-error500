require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Attributes' do
    it { should respond_to :email }
    it { should respond_to :name }
    it { should respond_to :picture }
    it { should respond_to :phone }
    it { should respond_to :street }
    it { should respond_to :city }
  end

  describe 'Associations' do
    # Add associations if pertinent
  end
end
