class Api::V1::ReviewsController < ApplicationController
  before_action :set_api_v1_review, only: %i[show update destroy]
  before_action :authenticate_user!

  # GET /api/v1/reviews
  # GET /api/v1/reviews.json
  def index
    @api_v1_reviews = Review.all
    render json: @api_v1_reviews
  end

  # GET /api/v1/reviews/1
  # GET /api/v1/reviews/1.json
  def show; end

  # POST /api/v1/reviews
  # POST /api/v1/reviews.json
  def create
    @user = User.find(api_v1_review_params[:user_id])
    @leaseholder = @user.leaseholder

    if @leaseholder.nil?
      render json: { result: 'Este usuario no es leaseholder' }, status: :unprocessable_entity
      return
    end

    @api_v1_review = Review.new(
      score: api_v1_review_params[:score],
      comment: api_v1_review_params[:comment],
      leaseholder_id: @leaseholder.id
    )

    if @api_v1_review.save
      response = { result: 'Review success' }
      render json: response, status: :created
    else
      render json: @api_v1_review.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/reviews/1
  # PATCH/PUT /api/v1/reviews/1.json
  def update
    if @api_v1_review.update(api_v1_review_params)
      render :show, status: :ok, location: @api_v1_review
    else
      render json: @api_v1_review.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/reviews/1
  # DELETE /api/v1/reviews/1.json
  def destroy
    @api_v1_review.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_api_v1_review
    @api_v1_review = Review.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def api_v1_review_params
    params.require(:api_v1_review).permit(:score, :comment, :leaseholder_id, :user_id)
  end
end
