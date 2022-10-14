class Api::V1::LeaseholdersController < ApplicationController
  before_action :set_api_v1_leaseholder, only: %i[ show update destroy ]
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
    if @api_v1_leaseholder.update(api_v1_leaseholder_params)
      render :show, status: :ok, location: @api_v1_leaseholder
    else
      render json: @api_v1_leaseholder.errors, status: :unprocessable_entity
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
