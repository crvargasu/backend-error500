class Api::V1::LessorsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_api_v1_lessor, only: %i[ show update destroy ]

  # GET /api/v1/lessors
  # GET /api/v1/lessors.json
  def index
    @api_v1_lessors = Api::V1::Lessor.all
    render json: @api_v1_lessors
  end

  # GET /api/v1/lessors/1
  # GET /api/v1/lessors/1.json
  def show
  end

  # POST /api/v1/lessors
  # POST /api/v1/lessors.json
  def create
    print("create")
    print(api_v1_lessor_params)
    @api_v1_lessor = Api::V1::Lessor.new(api_v1_lessor_params)

    if @api_v1_lessor.save
      render json: @api_v1_lessor
    else
      render json: @api_v1_lessor.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/lessors/1
  # PATCH/PUT /api/v1/lessors/1.json
  def update
    if @api_v1_lessor.update(api_v1_lessor_params)
      render :show, status: :ok, location: @api_v1_lessor
    else
      render json: @api_v1_lessor.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/lessors/1
  # DELETE /api/v1/lessors/1.json
  def destroy
    @api_v1_lessor.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_lessor
      @api_v1_lessor = Api::V1::Lessor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_v1_lessor_params
      params.require(:api_v1_lessor).permit(:credit, :mean_reviews, :user_id)
    end
end
