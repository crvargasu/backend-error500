# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'Attributes' do
    it { should respond_to :score }
    it { should respond_to :comment }
    it { should respond_to :leaseholder_id }
  end

  describe 'Associations' do
    it { should belong_to(:leaseholder) }
  end
end
