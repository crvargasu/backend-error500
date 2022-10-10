class CreateApiV1Lessors < ActiveRecord::Migration[7.0]
  def change
    create_table :api_v1_lessors do |t|
      t.integer :credit
      t.integer :mean_reviews

      t.timestamps
    end
  end
end
