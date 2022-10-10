class AddLeaseholderToReviews < ActiveRecord::Migration[7.0]
  def change
    add_reference :api_v1_reviews, :api_v1_leaseholders, null: false, foreign_key: true
  end
end