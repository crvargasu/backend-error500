# frozen_string_literal: true

class RentalAgreement < ApplicationRecord
  belongs_to :leaseholder
  belongs_to :lessor
  enum status: { pending: 0, approved: 1, denied: 2 }
end
