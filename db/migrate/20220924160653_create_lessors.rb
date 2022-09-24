class CreateLessors < ActiveRecord::Migration[7.0]
  def change
    create_table :lessors do |t|
      t.integer :credit
      t.integer :mean_reviews

      t.timestamps
    end
  end
end
