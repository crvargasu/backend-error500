class Api::V1::RentalAgreementsController < ApplicationController
  # before_action :set_api_v1_rental_agreement, only: %i[ show update destroy ]
  ActionController::Parameters.permit_all_parameters = true
  before_action :authenticate_user!

  # GET /api/v1/rental_agreements
  # GET /api/v1/rental_agreements.json
  def index
    @api_v1_rental_agreements = RentalAgreement.all
    render json: @api_v1_rental_agreements
  end

  def pending_rental_agreements
    if(Leaseholder.where(user_id: params[:id]).exists?)
      leaseholder = Leaseholder.where(user_id: params[:id])[0]
      agreements = RentalAgreement.where(leaseholder_id: leaseholder.user_id, status: "pending")
      render json: {"RentalAgreements": agreements}, status: :ok
    else
      lessor = Lessor.where(user_id: params[:id])[0]
      agreements = RentalAgreement.where(lessor_id: lessor.user_id, status: "pending")
      render json: {"RentalAgreements": agreements}, status: :ok
    end
  end

  # GET /api/v1/rental_agreements/1
  # GET /api/v1/rental_agreements/1.json
  def show
    if(RentalAgreement.where(id: params[:id]).exists?)
      agreement = RentalAgreement.where(id: params[:id])[0]
      render json: {"RentalAgreement": agreement}, status: :ok
    else
      render json: { message: "Rental Agreement not found."}, status: :not_found
    end
  end

  def user_rental_agreements
    if(Leaseholder.where(user_id: params[:id]).exists?)
      leaseholder = Leaseholder.where(user_id: params[:id])[0]
      agreements = RentalAgreement.where(leaseholder_id: leaseholder.user_id)
      render json: {"RentalAgreements": agreements}, status: :ok
    else
      lessor = Lessor.where(user_id: params[:id])[0]
      agreements = RentalAgreement.where(lessor_id: lessor.user_id)
      render json: {"RentalAgreements": agreements}, status: :ok
    end
  end

  # POST /api/v1/rental_agreements
  # POST /api/v1/rental_agreements.json
  def create
    @api_v1_rental_agreement = RentalAgreement.new(api_v1_rental_agreement_params)
    @api_v1_rental_agreement.status = false

    if @api_v1_rental_agreement.save
      render json: { result: 'Rental Agreement created' }, status: :created
    else
      render json: @api_v1_rental_agreement.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/rental_agreements/1
  # PATCH/PUT /api/v1/rental_agreements/1.json
  def update
    if @api_v1_rental_agreement.update(api_v1_rental_agreement_params)
      render :show, status: :ok, location: @api_v1_rental_agreement
    else
      render json: @api_v1_rental_agreement.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/rental_agreements/1
  # DELETE /api/v1/rental_agreements/1.json
  def destroy
    @api_v1_rental_agreement.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_api_v1_rental_agreement
    @api_v1_rental_agreement = RentalAgreement.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def api_v1_rental_agreement_params
    params.require(:api_v1_rental_agreement).permit(
      :timestamp_start, :lessor_id, :leaseholder_id, :reasons, :offer_price
    )
  end
end
