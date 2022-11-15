# frozen_string_literal: true

module Api
  module V1
    class LessorsController < ApplicationController
      ActionController::Parameters.permit_all_parameters = true
      before_action :authenticate_user!

      # GET /api/v1/lessors
      # GET /api/v1/lessors.json
      def index
        @api_v1_lessors = Lessor.all
        render json: @api_v1_lessors.to_json(include: [:user])
      end

      # GET /api/v1/lessors/1
      # GET /api/v1/lessors/1.json
      def show
        if Lessor.where(user_id: params[:id]).exists?
          lessor = Lessor.where(user_id: params[:id])[0]
          user = User.find(params[:id])
          render json: { "user": user, "other": lessor }, status: :ok
        else
          render json: { message: 'Lessor not found.' }, status: :not_found
        end
      end

      # POST /api/v1/lessors
      # POST /api/v1/lessors.json
      def create
        @api_v1_lessor = Lessor.new(api_v1_lessor_params)

        if @api_v1_lessor.save
          render json: @api_v1_lessor
        else
          render json: @api_v1_lessor.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/lessors/1
      # PATCH/PUT /api/v1/lessors/1.json
      def update
        if Lessor.where(user_id: params[:id]).exists?
          @lessor = Lessor.where(user_id: params[:id])[0]
          @lessor.update(params[:other])
          @user = User.find(params[:id])
          @user.update(params[:user])
          render json: { "user": @user, "other": @lessor }, status: :ok
        else
          render json: { message: 'Lessor not found.' }, status: :not_found
        end
      end

      # DELETE /api/v1/lessors/1
      # DELETE /api/v1/lessors/1.json
      def destroy
        @api_v1_lessor = Lessor.find(params[:id])
        @api_v1_lessor.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_api_v1_lessor
        @api_v1_lessor = Lessor.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def api_v1_lessor_params
        params.require(:api_v1_lessor).permit(:credit, :mean_reviews, :user_id)
      end
    end
  end
end
