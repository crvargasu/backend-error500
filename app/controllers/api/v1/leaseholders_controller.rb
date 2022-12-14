# frozen_string_literal: true

module Api
  module V1
    class LeaseholdersController < ApplicationController
      ActionController::Parameters.permit_all_parameters = true
      before_action :authenticate_user!

      # GET /api/v1/leaseholders
      # GET /api/v1/leaseholders.json
      def index
        @api_v1_leaseholders = Leaseholder.where(status: true)
        @api_v1_leaseholder_validity = []
        @api_v1_leaseholders.each do |leaseholder|
          calculate_mean_reviews(leaseholder)
          calculate_validity(leaseholder)
        end
        render json: @api_v1_leaseholder_validity.to_json(include: %i[user rental_agreements])
      end

      # GET /api/v1/leaseholders/pending/all
      def pending_leaseholders
        @api_v1_leaseholders = Leaseholder.where(status: false)
        @api_v1_leaseholders.each do |leaseholder|
          calculate_mean_reviews(leaseholder)
        end
        render json: @api_v1_leaseholders.to_json(include: %i[user rental_agreements]), status: :ok
      end

      # GET /api/v1/leaseholders/1
      # GET /api/v1/leaseholders/1.json
      def show
        if Leaseholder.exists?(user_id: params[:id])
          leaseholder = Leaseholder.where(user_id: params[:id])[0]
          calculate_mean_reviews(leaseholder)
          user = User.find(params[:id])
          render json: { user: user, other: leaseholder }, status: :ok
        else
          render json: { message: 'Leaseholder not found.' }, status: :not_found
        end
      end

      # POST /api/v1/leaseholders
      # POST /api/v1/leaseholders.json
      def create
        params[:other]
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
        if Leaseholder.exists?(user_id: params[:id])
          @leaseholder = Leaseholder.where(user_id: params[:id])[0]
          @leaseholder.update(params[:other]) if params[:other]
          if params[:user]
            @user = User.find(params[:id])
            @user.update(params[:user])
          end
          render json: { user: @user, other: @leaseholder }, status: :ok
        else
          render json: { message: 'Leaseholder not found.' }, status: :not_found
        end
      end

      # DELETE /api/v1/leaseholders/1
      # DELETE /api/v1/leaseholders/1.json
      def destroy
        @api_v1_leaseholder = Leaseholder.find(params[:id])
        @api_v1_leaseholder.update(status: false)
        render json: { message: 'Leaseholder destroyed' }, status: :ok
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

      def calculate_mean_reviews(leaseholder)
        mean_score = 0
        leaseholder.reviews.each do |l|
          mean_score += l.score
        end
        mean_score /= leaseholder.reviews.length.to_f if leaseholder.reviews.length.positive?
        mean_score = mean_score.round
        leaseholder.update(mean_reviews: mean_score)
      end

      def calculate_validity(leaseholder)
        current_timestamp = Time.zone.now.getutc
        agreements = RentalAgreement.where('timestamp_start < ?',
                                           current_timestamp).where(leaseholder_id: leaseholder.id, status: 'approved')
        space = if agreements.exists?
                  leaseholder.capacity - agreements.count
                else
                  leaseholder.capacity
                end
        @api_v1_leaseholder_validity << leaseholder if space.positive?
      end
    end
  end
end
