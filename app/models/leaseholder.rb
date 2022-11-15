# frozen_string_literal: true

class Leaseholder < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :rental_agreements, dependent: :destroy
end
