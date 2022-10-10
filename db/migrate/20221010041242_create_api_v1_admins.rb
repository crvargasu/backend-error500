class CreateApiV1Admins < ActiveRecord::Migration[7.0]
  def change
    create_table :api_v1_admins do |t|

      t.timestamps
    end
  end
end
