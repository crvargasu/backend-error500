class CreateApiV1Leaseholders < ActiveRecord::Migration[7.0]
  def change
    create_table :api_v1_leaseholders do |t|
      t.string :property_account
      t.st_polygon :polygon
      t.integer :mean_reviews
      t.integer :credit
      t.boolean :status
      t.string :id_picture_front
      t.string :id_picture_back

      t.timestamps
    end
  end
end
