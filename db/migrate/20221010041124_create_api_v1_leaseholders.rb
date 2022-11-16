# frozen_string_literal: true

class CreateApiV1Leaseholders < ActiveRecord::Migration[7.0]
  def change
    create_table :leaseholders do |t|
      t.string :property_account, :limit => 500
      t.text :description, :limit => 1000
      t.integer :capacity
      t.integer :highlimit
      t.string :polygon, :limit => 1000
      t.integer :area
      t.string :center, :limit => 100
      t.integer :mean_reviews
      t.integer :credit
      t.boolean :status
      t.string :id_picture_front, :limit => 500
      t.string :id_picture_back, :limit => 500

      t.timestamps
    end
  end
end
