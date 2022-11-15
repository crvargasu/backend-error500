# frozen_string_literal: true

require 'test_helper'

module Api
  module V1
    class RentalAgreementsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @api_v1_rental_agreement = api_v1_rental_agreements(:one)
      end

      test 'should get index' do
        get api_v1_rental_agreements_url, as: :json
        assert_response :success
      end

      test 'should create api_v1_rental_agreement' do
        assert_difference('Api::V1::RentalAgreement.count') do
          post api_v1_rental_agreements_url,
               params: { api_v1_rental_agreement: { content: @api_v1_rental_agreement.content, title: @api_v1_rental_agreement.title } }, as: :json
        end

        assert_response :created
      end

      test 'should show api_v1_rental_agreement' do
        get api_v1_rental_agreement_url(@api_v1_rental_agreement), as: :json
        assert_response :success
      end

      test 'should update api_v1_rental_agreement' do
        patch api_v1_rental_agreement_url(@api_v1_rental_agreement),
              params: { api_v1_rental_agreement: { content: @api_v1_rental_agreement.content, title: @api_v1_rental_agreement.title } }, as: :json
        assert_response :success
      end

      test 'should destroy api_v1_rental_agreement' do
        assert_difference('Api::V1::RentalAgreement.count', -1) do
          delete api_v1_rental_agreement_url(@api_v1_rental_agreement), as: :json
        end

        assert_response :no_content
      end
    end
  end
end
