# frozen_string_literal: true

class CreateApiV1Admins < ActiveRecord::Migration[7.0]
  def change
    create_table :admins, &:timestamps
  end
end
