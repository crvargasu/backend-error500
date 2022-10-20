class Api::V1::LeaseholdersController < ApplicationController
  ActionController::Parameters.permit_all_parameters = true
  before_action :authenticate_user!

  # GET /api/v1/leaseholders
  # GET /api/v1/leaseholders.json
  def index
    @api_v1_leaseholders = Leaseholder.all
    render json: @api_v1_leaseholders
  end

  # GET /api/v1/leaseholders/1
  # GET /api/v1/leaseholders/1.json
  def show
    if(Leaseholder.where(user_id: params[:id]).exists?)
      leaseholder = Leaseholder.where(user_id: params[:id])[0]
      user = User.find(params[:id])
      render json: {"user": user, "other": leaseholder}, status: :ok
    else
      render json: { message: "Leaseholder not found."}, status: :not_found
    end
  end

  # POST /api/v1/leaseholders
  # POST /api/v1/leaseholders.json
  def create
    @api_v1_leaseholder = Leaseholder.new(api_v1_leaseholder_params)

    if @api_v1_leaseholder.save
      render :show, status: :created, location: @api_v1_leaseholder
    else
      render json: @api_v1_leaseholder.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/leaseholders/1
  # PATCH/PUT /api/v1/leaseholders/1.json
  def update
    if(Leaseholder.where(user_id: params[:id]).exists?)
      @leaseholder = Leaseholder.where(user_id: params[:id])[0]
      @leaseholder.update(params[:other])
      @user = User.find(params[:id])
      @user.update(params[:user])
      render json: {"user": @user, "other": @leaseholder}, status: :ok
    else
      render json: { message: "Leaseholder not found."}, status: :not_found
    end
  end

  # DELETE /api/v1/leaseholders/1
  # DELETE /api/v1/leaseholders/1.json
  def destroy
    @api_v1_leaseholder.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_leaseholder
      @api_v1_leaseholder = Leaseholder.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_v1_leaseholder_params
      params.require(:api_v1_leaseholder).permit(:title, :content)
    end
end
