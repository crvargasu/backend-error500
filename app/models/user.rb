# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable,
         :jwt_authenticatable,
         :registerable,
         jwt_revocation_strategy: JwtDenylist

  has_one :leaseholder, required: false, dependent: :destroy
  has_one :lessor, required: false, dependent: :destroy
end
