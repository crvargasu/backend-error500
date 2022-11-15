# frozen_string_literal: true

class CreateApiV1RentalAgreements < ActiveRecord::Migration[7.0]
  def change
    create_table :rental_agreements do |t|
      t.timestamp :timestamp_start
      t.timestamp :timestamp_end
      t.integer :status

      t.timestamps
    end
  end
end
