# frozen_string_literal: true

class AddDaysForWeekToRentalAgreements < ActiveRecord::Migration[7.0]
  def change
    add_column :rental_agreements, :days_for_week, :integer
  end
end
