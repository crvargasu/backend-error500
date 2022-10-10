class CreateApiV1Reviews < ActiveRecord::Migration[7.0]
  def change
    create_table :api_v1_reviews do |t|
      t.integer :score
      t.text :comment

      t.timestamps
    end
  end
end
