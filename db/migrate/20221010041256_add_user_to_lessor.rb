class AddUserToLessor < ActiveRecord::Migration[7.0]
  def change
    add_reference :api_v1_lessors, :user, null: false, foreign_key: true
  end
end
