# frozen_string_literal: true

require 'test_helper'

module Api
  module V1
    class ReviewsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @api_v1_review = api_v1_reviews(:one)
      end

      test 'should get index' do
        get api_v1_reviews_url, as: :json
        assert_response :success
      end

      test 'should create api_v1_review' do
        assert_difference('Api::V1::Review.count') do
          post api_v1_reviews_url,
               params: { api_v1_review: { content: @api_v1_review.content, title: @api_v1_review.title } }, as: :json
        end

        assert_response :created
      end

      test 'should show api_v1_review' do
        get api_v1_review_url(@api_v1_review), as: :json
        assert_response :success
      end

      test 'should update api_v1_review' do
        patch api_v1_review_url(@api_v1_review),
              params: { api_v1_review: { content: @api_v1_review.content, title: @api_v1_review.title } }, as: :json
        assert_response :success
      end

      test 'should destroy api_v1_review' do
        assert_difference('Api::V1::Review.count', -1) do
          delete api_v1_review_url(@api_v1_review), as: :json
        end

        assert_response :no_content
      end
    end
  end
end
