# frozen_string_literal: true

class AddFieldsToRentalAgreements < ActiveRecord::Migration[7.0]
  def change
    add_column :rental_agreements, :reasons, :string, limit: 100
    add_column :rental_agreements, :offer_price, :decimal
  end
end
