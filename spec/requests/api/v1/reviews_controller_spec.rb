# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ReviewsController', type: :request do # rubocop:disable Metrics/BlockLength
  describe 'GET /api/v1/reviews' do
    let(:user) { create(:user) }
    let(:auth) { auth_headers(user) }
    let!(:reviews) { create_list(:review, 3) }

    context 'when logged in' do
      before do
        get '/api/v1/reviews', headers: auth
      end

      it 'return status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns 3 reviews' do
        expect(JSON.parse(response.body).length).to eq(3)
      end
    end
  end

  describe 'POST /api/v1/reviews' do # rubocop:disable Metrics/BlockLength
    let(:user) { create(:user) }
    let(:auth) { auth_headers(user) }
    let!(:leaseholder) { create(:leaseholder, user: user) }

    let(:user_with_no_leaseholder) { create(:user) }
    let(:auth2) { auth_headers(user_with_no_leaseholder) }

    context 'when user has leaseholder and params are valid' do
      before do
        params = {
          api_v1_review: {
            user_id: user.id,
            score: 5,
            comment: 'Comment'
          }
        }

        post '/api/v1/reviews', headers: auth, params: params.to_json
      end

      it 'return status 200' do
        expect(response).to have_http_status(:created)
      end

      it 'should create a review with correct score' do
        expect(Review.last.score).to eq(5)
      end

      it 'should create a review with correct comment' do
        expect(Review.last.comment).to eq('Comment')
      end
    end

    context 'when user has no leaseholder and params are valid' do
      before do
        params = {
          api_v1_review: {
            user_id: user_with_no_leaseholder.id,
            score: 5,
            comment: 'Comment'
          }
        }

        post '/api/v1/reviews', headers: auth2, params: params.to_json
      end

      it 'return status 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
