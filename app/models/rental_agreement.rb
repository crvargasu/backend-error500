# frozen_string_literal: true

class RentalAgreement < ApplicationRecord
  belongs_to :leaseholder
  belongs_to :lessor
  enum status: %i[pending approved denied]
end
