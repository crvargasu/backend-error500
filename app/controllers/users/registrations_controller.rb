class Users::RegistrationsController < Devise::RegistrationsController
  ActionController::Parameters.permit_all_parameters = true
  include RackSessionFix
  respond_to :json
  def create
    super do |user|
      params[:user][:others][:user_id] = user.id
      if params[:user][:type] == 'lessor'
        @api_v1_lessor = Lessor.new(params[:user][:others])
        @api_v1_lessor.save
      else
        @api_v1_leaseholder = Leaseholder.new(params[:user][:others])
        @api_v1_leaseholder.save
      end
    end
  end

  def respond_with(resource, _opts = {})
    resource.persisted? ? register_success : register_failed
  end

  def register_success
    render json: { message: 'Signed up.' }
  end

  def register_failed
    render json: { message: 'Signed up failure.' }
  end
end
