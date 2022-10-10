class AddLeaseholderToRentalAgreements < ActiveRecord::Migration[7.0]
  def change
    add_reference :api_v1_rental_agreements, :api_v1_leaseholder, null: false, foreign_key: true
  end
end
