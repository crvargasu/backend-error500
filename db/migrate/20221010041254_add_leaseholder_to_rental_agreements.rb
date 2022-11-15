# frozen_string_literal: true

class AddLeaseholderToRentalAgreements < ActiveRecord::Migration[7.0]
  def change
    add_reference :rental_agreements, :leaseholder, null: false, foreign_key: true
  end
end
