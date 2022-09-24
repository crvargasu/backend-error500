class RentalAgreementsController < ApplicationController
  before_action :set_rental_agreement, only: %i[ show edit update destroy ]

  # GET /rental_agreements or /rental_agreements.json
  def index
    @rental_agreements = RentalAgreement.all
  end

  # GET /rental_agreements/1 or /rental_agreements/1.json
  def show
  end

  # GET /rental_agreements/new
  def new
    @rental_agreement = RentalAgreement.new
  end

  # GET /rental_agreements/1/edit
  def edit
  end

  # POST /rental_agreements or /rental_agreements.json
  def create
    @rental_agreement = RentalAgreement.new(rental_agreement_params)

    respond_to do |format|
      if @rental_agreement.save
        format.html { redirect_to rental_agreement_url(@rental_agreement), notice: "Rental agreement was successfully created." }
        format.json { render :show, status: :created, location: @rental_agreement }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rental_agreement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rental_agreements/1 or /rental_agreements/1.json
  def update
    respond_to do |format|
      if @rental_agreement.update(rental_agreement_params)
        format.html { redirect_to rental_agreement_url(@rental_agreement), notice: "Rental agreement was successfully updated." }
        format.json { render :show, status: :ok, location: @rental_agreement }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rental_agreement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rental_agreements/1 or /rental_agreements/1.json
  def destroy
    @rental_agreement.destroy

    respond_to do |format|
      format.html { redirect_to rental_agreements_url, notice: "Rental agreement was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rental_agreement
      @rental_agreement = RentalAgreement.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rental_agreement_params
      params.require(:rental_agreement).permit(:timestamp_start, :timestamp_end, :status)
    end
end
