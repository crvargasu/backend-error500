class Api::V1::AdminsController < ApplicationController
  before_action :set_api_v1_admin, only: %i[show update destroy]
  before_action :authenticate_user!

  # GET /api/v1/admins
  # GET /api/v1/admins.json
  def index
    @api_v1_admins = Admin.all
    render json: @api_v1_admins
  end

  # GET /api/v1/admins/1
  # GET /api/v1/admins/1.json
  def show; end

  # POST /api/v1/admins
  # POST /api/v1/admins.json
  def create
    @api_v1_admin = Admin.new(api_v1_admin_params)

    if @api_v1_admin.save
      render :show, status: :created, location: @api_v1_admin
    else
      render json: @api_v1_admin.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/admins/1
  # PATCH/PUT /api/v1/admins/1.json
  def update
    if @api_v1_admin.update(api_v1_admin_params)
      render :show, status: :ok, location: @api_v1_admin
    else
      render json: @api_v1_admin.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/admins/1
  # DELETE /api/v1/admins/1.json
  def destroy
    @api_v1_admin.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_api_v1_admin
    @api_v1_admin = Admin.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def api_v1_admin_params
    params.require(:api_v1_admin).permit(:title, :content)
  end
end
