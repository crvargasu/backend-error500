class AddLessorToRentalAgreements < ActiveRecord::Migration[7.0]
  def change
    add_reference :api_v1_rental_agreements, :api_v1_lessor, null: false, foreign_key: true
  end
end
