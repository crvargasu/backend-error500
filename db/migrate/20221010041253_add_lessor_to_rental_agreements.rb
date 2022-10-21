class AddLessorToRentalAgreements < ActiveRecord::Migration[7.0]
  def change
    add_reference :rental_agreements, :lessor, null: false, foreign_key: true
  end
end
