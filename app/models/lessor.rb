# frozen_string_literal: true

class Lessor < ApplicationRecord
  belongs_to :user
  has_many :rental_agreements
end
