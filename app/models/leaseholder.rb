# frozen_string_literal: true

class Leaseholder < ApplicationRecord
  belongs_to :user
  has_many :reviews
  has_many :rental_agreements
end
