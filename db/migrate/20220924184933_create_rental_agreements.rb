class CreateRentalAgreements < ActiveRecord::Migration[7.0]
  def change
    create_table :rental_agreements do |t|
      t.timestamp :timestamp_start
      t.timestamp :timestamp_end
      t.boolean :status

      t.timestamps
    end
  end
end
