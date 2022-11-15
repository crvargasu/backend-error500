# frozen_string_literal: true

module Api
  module V1
    class UserController < ApplicationController
      before_action :authenticate_user!

      def me
        if Lessor.exists?(user_id: current_user.id)
          lessor = Lessor.where(user_id: current_user.id)[0]
          render json: { user: current_user, other: lessor }, status: :ok
        else
          leaseholder = Leaseholder.where(user_id: current_user.id)[0]
          render json: { user: current_user, other: leaseholder }, status: :ok
        end
      end
    end
  end
end
