class Api::V1::RentalAgreement < ApplicationRecord
    belongs_to :leaseholder
    belongs_to :lessor
end
