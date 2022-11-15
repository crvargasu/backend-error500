# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'LessorsController', type: :request do
  describe 'GET /api/v1/lessors' do
    let(:user) { create(:user) }
    let(:auth) { auth_headers(user) }
    let!(:lessors) { create_list(:lessor, 5) }

    context 'when logged in' do
      before do
        get '/api/v1/lessors', headers: auth
      end

      it 'return status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns 5 lessors' do
        expect(JSON.parse(response.body).length).to eq(5)
      end
    end
  end

  describe 'GET /api/v1/lessors/:id' do
    let(:user) { create(:user) }
    let(:auth) { auth_headers(user) }
    let!(:lessor) { create(:lessor, user: user) }

    let(:user_with_no_lessor) { create(:user) }
    let(:auth2) { auth_headers(user_with_no_lessor) }

    context 'user has lessor' do
      before do
        get "/api/v1/lessors/#{user.id}", headers: auth
      end

      it 'return status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns correct user' do
        expect(JSON.parse(response.body)['user']['id']).to eq(user.id)
      end

      it 'returns correct lessor' do
        expect(JSON.parse(response.body)['other']['id']).to eq(lessor.id)
      end
    end

    context 'user has no lessor' do
      before do
        get "/api/v1/lessors/#{user_with_no_lessor.id}", headers: auth2
      end

      it 'return status 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'PUT /api/v1/lessors/:id' do
    let(:user) { create(:user) }
    let(:auth) { auth_headers(user) }
    let!(:lessors) { create(:lessor, credit: 3, user: user) }

    let(:user_with_no_lessors) { create(:user) }
    let(:auth2) { auth_headers(user_with_no_lessors) }

    context 'when changing existing lessors' do
      before do
        params = {
          user: {},
          other: {
            credit: 5
          }
        }
        put "/api/v1/lessors/#{user.id}", headers: auth, params: params.to_json
        lessors.reload
      end

      it 'return status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'should update lessors' do
        expect(lessors.credit).to eq(5)
      end
    end

    context 'when user has no lessors' do
      before do
        put "/api/v1/lessors/#{user_with_no_lessors.id}", headers: auth2
      end

      it 'return status 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE /api/v1/lessors/:id' do
    let(:user) { create(:user) }
    let(:auth) { auth_headers(user) }
    let(:lessor) { create(:lessor, user: user) }

    context 'when logged in' do
      before do
        delete "/api/v1/lessors/#{lessor.id}", headers: auth
      end

      it 'should change status to approved' do
        expect(Lessor.exists?(lessor.id)).to eq(false)
      end
    end
  end
end
