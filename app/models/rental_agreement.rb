class RentalAgreement < ApplicationRecord
    belongs_to :leaseholder
    belongs_to :lessor
    enum status: [:pending, :approved, :denied]
end
