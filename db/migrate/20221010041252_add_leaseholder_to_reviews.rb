class AddLeaseholderToReviews < ActiveRecord::Migration[7.0]
  def change
    add_reference :reviews, :leaseholder, null: false, foreign_key: true
  end
end
