class CreateApiV1Reviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.integer :score
      t.text :comment

      t.timestamps
    end
  end
end
