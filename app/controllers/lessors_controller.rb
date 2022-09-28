class LessorsController < ApplicationController
  before_action :set_lessor, only: %i[ show edit update destroy ]

  # GET /lessors or /lessors.json
  def index
    @lessors = Lessor.all
    render json: @lessors
  end

  # GET /lessors/1 or /lessors/1.json
  def show
    render json: @lessor
  end

  # GET /lessors/new
  def new
    @lessor = Lessor.new
  end

  # GET /lessors/1/edit
  def edit
  end

  # POST /lessors or /lessors.json
  def create
    @lessor = Lessor.new(lessor_params)

    respond_to do |format|
      if @lessor.save
        format.html { redirect_to lessor_url(@lessor), notice: "Lessor was successfully created." }
        format.json { render :show, status: :created, location: @lessor }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lessor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lessors/1 or /lessors/1.json
  def update
    respond_to do |format|
      if @lessor.update(lessor_params)
        format.html { redirect_to lessor_url(@lessor), notice: "Lessor was successfully updated." }
        format.json { render :show, status: :ok, location: @lessor }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lessor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessors/1 or /lessors/1.json
  def destroy
    @lessor.destroy

    respond_to do |format|
      format.html { redirect_to lessors_url, notice: "Lessor was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lessor
      @lessor = Lessor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lessor_params
      params.require(:lessor).permit(:credit, :mean_reviews, :user_id)
    end
end