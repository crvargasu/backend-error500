class LeaseholdersController < ApplicationController
  before_action :set_leaseholder, only: %i[ show edit update destroy ]

  # GET /leaseholders or /leaseholders.json
  def index
    @leaseholders = Leaseholder.all
    render json: @leaseholders
  end

  # GET /leaseholders/1 or /leaseholders/1.json
  def show
  end

  # GET /leaseholders/new
  def new
    @leaseholder = Leaseholder.new
  end

  # GET /leaseholders/1/edit
  def edit
  end

  # POST /leaseholders or /leaseholders.json
  def create
    @leaseholder = Leaseholder.new(leaseholder_params)

    respond_to do |format|
      if @leaseholder.save
        format.html { redirect_to leaseholder_url(@leaseholder), notice: "Leaseholder was successfully created." }
        format.json { render :show, status: :created, location: @leaseholder }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @leaseholder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leaseholders/1 or /leaseholders/1.json
  def update
    respond_to do |format|
      if @leaseholder.update(leaseholder_params)
        format.html { redirect_to leaseholder_url(@leaseholder), notice: "Leaseholder was successfully updated." }
        format.json { render :show, status: :ok, location: @leaseholder }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @leaseholder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leaseholders/1 or /leaseholders/1.json
  def destroy
    @leaseholder.destroy

    respond_to do |format|
      format.html { redirect_to leaseholders_url, notice: "Leaseholder was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_leaseholder
      @leaseholder = Leaseholder.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def leaseholder_params
      params.require(:leaseholder).permit(:user_id, :property_account, :polygon, :mean_reviews, :credit, :status, :id_picture_front, :id_picture_back)
    end
end
