# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    respond_to :json

    private

    def respond_with(_resource, _opts = {})
      current_user ? log_in_success : log_in_failure
    end

    def respond_to_on_destroy
      current_user ? log_out_failure : log_out_success
    end

    def log_in_success
      if current_user.role == 'admin'
        render json: { user: current_user.attributes.merge(type: 'admin') }, status: :ok
        return
      end

      render_lessor if Lessor.exists?(user_id: current_user.id)
      return unless Leaseholder.exists?(user_id: current_user.id)

      render_leaseholder
    end

    def render_lessor
      lessor = Lessor.where(user_id: current_user.id)
      render json: { user: current_user.attributes.merge(type: 'lessor'),
                     other: lessor[0] }, status: :ok
    end

    def render_leaseholder
      leaseholder = Leaseholder.where(user_id: current_user.id)
      render json: { user: current_user.attributes.merge(type: 'leaseholder'),
                     other: leaseholder[0] }, status: :ok
    end

    def log_in_failure
      render json: { message: 'Logged in failure.' }, status: :unauthorized
    end

    def log_out_success
      render json: { message: 'Logged out.' }, status: :ok
    end

    def log_out_failure
      render json: { message: 'Logged out failure.' }, status: :unauthorized
    end
  end
end
