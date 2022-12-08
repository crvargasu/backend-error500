# frozen_string_literal: true

module Api
  module V1
    class RentalAgreementsController < ApplicationController
      before_action :set_api_v1_rental_agreement, only: %i[update]
      ActionController::Parameters.permit_all_parameters = true
      before_action :authenticate_user!

      # GET /api/v1/rental_agreements
      # GET /api/v1/rental_agreements.json
      def index
        @api_v1_rental_agreements = RentalAgreement.all
        render json: @api_v1_rental_agreements.to_json(include: {
                                                         leaseholder: { include: :user },
                                                         lessor: { include: :user }
                                                       })
      end

      def pending_rental_agreements
        if Leaseholder.exists?(user_id: params[:id])
          leaseholder = Leaseholder.where(user_id: params[:id])[0]
          agreements = RentalAgreement.where(leaseholder_id: leaseholder.user_id, status: %w[pending denied])
        else
          lessor = Lessor.where(user_id: params[:id])[0]
          agreements = RentalAgreement.where(lessor_id: lessor.user_id, status: %w[pending denied])
        end
        agreements = merge_leaseholder_to_rental_agreements(agreements)
        agreements = merge_lessor_to_rental_agreements(agreements)
        render json: { RentalAgreements: agreements }, status: :ok
      end

      # GET /api/v1/rental_agreements/1
      # GET /api/v1/rental_agreements/1.json
      def show
        if RentalAgreement.exists?(id: params[:id])
          agreement = RentalAgreement.where(id: params[:id])[0]
          agreement.attributes.merge(lessor: agreement.lessor.attributes.merge(user: agreement.lessor.user))
          agreement.attributes.merge(leaseholder: agreement.leaseholder.attributes.merge(user: agreement.leaseholder.user))
          render json: { RentalAgreement: agreement }, status: :ok
        else
          render json: { message: 'Rental Agreement not found.' }, status: :not_found
        end
      end

      def user_rental_agreements
        if Leaseholder.exists?(user_id: params[:id])
          user_rental_agreements_leaseholder
        else
          user_rental_agreements_lessor
        end
      end

      # POST /api/v1/rental_agreements
      # POST /api/v1/rental_agreements.json
      def create
        @api_v1_rental_agreement = RentalAgreement.new(api_v1_rental_agreement_params)
        @api_v1_rental_agreement.status = 0

        if @api_v1_rental_agreement.save
          render json: @api_v1_rental_agreement, status: :created
        else
          render json: @api_v1_rental_agreement.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/rental_agreements/1
      # PATCH/PUT /api/v1/rental_agreements/1.json
      def update
        if @api_v1_rental_agreement.update(api_v1_rental_agreement_params)
          render json: { message: 'Rental Agreement updated' }, status: :ok
        else
          render json: @api_v1_rental_agreement.errors, status: :unprocessable_entity
        end
      end

      def approve_rental_agreement
        if params['api_v1_rental_agreement']['user_id'].blank?
          return render json: { message: 'Id usuario no presente' },
                        status: :bad_request
        end
        if params['api_v1_rental_agreement']['rental_agreement_id'].blank?
          return render json: { message: 'Id acuerdo no presente' },
                        status: :bad_request
        end

        agreement = RentalAgreement.find(params['api_v1_rental_agreement']['rental_agreement_id'])

        if agreement.update(status: 'approved')
          render json: { message: 'Rental agreement approved' }, status: :ok
        else
          render json: { message: 'Rental agreement could not be updated' }, status: :bad_request
        end
      end

      def reject_rental_agreement
        if params['api_v1_rental_agreement']['user_id'].blank?
          return render json: { message: 'Id usuario no presente' },
                        status: :bad_request
        end
        if params['api_v1_rental_agreement']['rental_agreement_id'].blank?
          return render json: { message: 'Id acuerdo no presente' },
                        status: :bad_request
        end

        agreement = RentalAgreement.find(params['api_v1_rental_agreement']['rental_agreement_id'])

        if agreement.destroy
          render json: { message: 'Rental agreement destroyed' }, status: :ok
        else
          render json: { message: 'Rental agreement could not be destroyed' }, status: :bad_request
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
          :timestamp_start, :lessor_id,
          :leaseholder_id, :reasons, :offer_price,
          :days_for_week, :timestamp_end, :status
        )
      end

      def merge_lessor_to_rental_agreements(agreements)
        agreements.each do |agreement|
          agreement.attributes.merge(lessor: agreement.lessor.attributes.merge(user: agreement.lessor.user))
        end
        agreements
      end

      def merge_leaseholder_to_rental_agreements(agreements)
        agreements.each do |agreement|
          agreement.attributes.merge(leaseholder: agreement.leaseholder.attributes.merge(user: agreement.leaseholder.user))
        end
        agreements
      end

      def user_rental_agreements_leaseholder
        leaseholder = Leaseholder.where(user_id: params[:id])[0]
        agreements = RentalAgreement.where(leaseholder_id: leaseholder.user_id)
        agreements = merge_lessor_to_rental_agreements(agreements)
        render json: { RentalAgreements: agreements, leaseholder: leaseholder.attributes.merge(user: leaseholder.user) }, status: :ok
      end

      def user_rental_agreements_lessor
        lessor = Lessor.where(user_id: params[:id])[0]
        agreements = RentalAgreement.where(lessor_id: lessor.user_id)
        agreements = merge_leaseholder_to_rental_agreements(agreements)
        render json: { RentalAgreements: agreements, lessor: lessor.attributes.merge(user: lessor.user) }, status: :ok
      end
    end
  end
end
