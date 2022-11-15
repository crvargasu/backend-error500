# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  describe 'GET /api/v1/me with leaseholder' do
    let(:user) { create(:user) }
    let(:auth) { auth_headers(user) }
    let!(:leaseholder) { create(:leaseholder, user: user) }

    context 'when getting information of a leaseholder' do
      before do
        get '/api/v1/me', headers: auth
      end

      it 'should return status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'should return user' do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['user']['id']).to eq(user.id)
      end

      it 'should return leaseholder' do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['other']['id']).to eq(leaseholder.id)
      end
    end
  end
  describe 'GET /api/v1/me with lessor' do
    let(:user) { create(:user) }
    let(:auth) { auth_headers(user) }
    let!(:lessor) { create(:lessor, user: user) }

    context 'when getting information of a lessor' do
      before do
        get '/api/v1/me', headers: auth
      end

      it 'should return status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'should return user' do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['user']['id']).to eq(user.id)
      end

      it 'should return lessor' do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['other']['id']).to eq(lessor.id)
      end
    end
  end
end
