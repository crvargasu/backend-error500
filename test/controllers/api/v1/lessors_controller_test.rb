# frozen_string_literal: true

require 'test_helper'

module Api
  module V1
    class LessorsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @api_v1_lessor = api_v1_lessors(:one)
      end

      test 'should get index' do
        get api_v1_lessors_url, as: :json
        assert_response :success
      end

      test 'should create api_v1_lessor' do
        assert_difference('Api::V1::Lessor.count') do
          post api_v1_lessors_url,
               params: { api_v1_lessor: { content: @api_v1_lessor.content, title: @api_v1_lessor.title } }, as: :json
        end

        assert_response :created
      end

      test 'should show api_v1_lessor' do
        get api_v1_lessor_url(@api_v1_lessor), as: :json
        assert_response :success
      end

      test 'should update api_v1_lessor' do
        patch api_v1_lessor_url(@api_v1_lessor),
              params: { api_v1_lessor: { content: @api_v1_lessor.content, title: @api_v1_lessor.title } }, as: :json
        assert_response :success
      end

      test 'should destroy api_v1_lessor' do
        assert_difference('Api::V1::Lessor.count', -1) do
          delete api_v1_lessor_url(@api_v1_lessor), as: :json
        end

        assert_response :no_content
      end
    end
  end
end
