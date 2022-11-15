# frozen_string_literal: true

require 'test_helper'

module Api
  module V1
    class LeaseholdersControllerTest < ActionDispatch::IntegrationTest
      setup do
        @api_v1_leaseholder = api_v1_leaseholders(:one)
      end

      test 'should get index' do
        get api_v1_leaseholders_url, as: :json
        assert_response :success
      end

      test 'should create api_v1_leaseholder' do
        assert_difference('Api::V1::Leaseholder.count') do
          post api_v1_leaseholders_url,
               params: { api_v1_leaseholder: { content: @api_v1_leaseholder.content, title: @api_v1_leaseholder.title } }, as: :json
        end

        assert_response :created
      end

      test 'should show api_v1_leaseholder' do
        get api_v1_leaseholder_url(@api_v1_leaseholder), as: :json
        assert_response :success
      end

      test 'should update api_v1_leaseholder' do
        patch api_v1_leaseholder_url(@api_v1_leaseholder),
              params: { api_v1_leaseholder: { content: @api_v1_leaseholder.content, title: @api_v1_leaseholder.title } }, as: :json
        assert_response :success
      end

      test 'should destroy api_v1_leaseholder' do
        assert_difference('Api::V1::Leaseholder.count', -1) do
          delete api_v1_leaseholder_url(@api_v1_leaseholder), as: :json
        end

        assert_response :no_content
      end
    end
  end
end
