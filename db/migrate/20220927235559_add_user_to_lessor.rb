class AddUserToLessor < ActiveRecord::Migration[7.0]
  def change
    add_reference :lessors, :user, null: false, foreign_key: true
  end
end
