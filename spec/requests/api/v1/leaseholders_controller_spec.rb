# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'LeaseholdersController', type: :request do # rubocop:disable Metrics/BlockLength
  describe 'GET /api/v1/leaseholders' do
    let(:user) { create(:user) }
    let(:auth) { auth_headers(user) }
    let!(:leaseholder) { create_list(:leaseholder, 3) }

    context 'when logged in' do
      before do
        get '/api/v1/leaseholders', headers: auth
      end

      it 'return status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns 3 leaseholders' do
        expect(JSON.parse(response.body).length).to eq(3)
      end
    end
  end

  describe 'GET /api/v1/leaseholders/:id' do # rubocop:disable Metrics/BlockLength
    let(:user1) { create(:user) }
    let(:auth1) { auth_headers(user1) }

    let(:user2) { create(:user) }
    let(:auth2) { auth_headers(user2) }

    let!(:leaseholder) { create(:leaseholder, user: user1) }

    context 'when user is a leaseholder' do
      before do
        get "/api/v1/leaseholders/#{user1.id}", headers: auth1
      end

      it 'return status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns correct user' do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['user']['id']).to eq(user1.id)
      end

      it 'returns leasholder' do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['other']['id']).to eq(leaseholder.id)
      end
    end

    context 'when user is not a leaseholder' do
      before do
        get "/api/v1/leaseholders/#{user2.id}", headers: auth2
      end

      it 'return status 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'PUT /api/v1/leaseholders/:id' do # rubocop:disable Metrics/BlockLength
    let(:user) { create(:user) }
    let(:auth) { auth_headers(user) }
    let!(:leaseholder) { create(:leaseholder, capacity: 50, user: user) }

    let(:user_with_no_leaseholder) { create(:user) }
    let(:auth2) { auth_headers(user_with_no_leaseholder) }

    context 'when changing existing leaseholder' do
      before do
        params = {
          user: {},
          other: {
            capacity: 20
          }
        }
        put "/api/v1/leaseholders/#{user.id}", headers: auth, params: params.to_json
        leaseholder.reload
      end

      it 'return status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'should update leaseholder' do
        expect(leaseholder.capacity).to eq(20)
      end
    end

    context 'when user has no leaseholder' do
      before do
        put "/api/v1/leaseholders/#{user_with_no_leaseholder.id}", headers: auth2
      end

      it 'return status 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
