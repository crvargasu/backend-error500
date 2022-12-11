# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'RentalAgreementsController', type: :request do # rubocop:disable Metrics/BlockLength
  describe 'GET /api/v1/rental_agreements' do
    let(:user) { create(:user) }
    let(:auth) { auth_headers(user) }
    let!(:rental_agreement) { create_list(:rental_agreement, 3) }

    describe 'HTTP Request' do
      context 'when logged in' do
        before do
          get '/api/v1/rental_agreements', headers: auth
        end

        it 'return status 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'returns 3 rental_agreements' do
          expect(JSON.parse(response.body).length).to eq(3)
        end
      end
      context 'when not logged in' do
        before do
          get '/api/v1/rental_agreements', headers: {}
        end

        it 'return status 401' do
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end
  describe 'GET /api/v1/rental_agreements/pending/:id with leaseholder' do
    let(:user) { create(:user) }
    let(:auth) { auth_headers(user) }

    let!(:leaseholder) { create(:leaseholder, user: user) }
    let!(:rental_agreement) { create(:rental_agreement, leaseholder: leaseholder, status: 'pending') }

    describe 'HTTP Request' do
      context 'when logged in' do
        before do
          get "/api/v1/rental_agreements/pending/#{user.id}", headers: auth
        end

        it 'return status 200' do
          expect(response).to have_http_status(:ok)
        end
      end
    end
  end
  describe 'GET /api/v1/rental_agreements/pending/:id with lessor' do
    let(:user) { create(:user) }
    let(:auth) { auth_headers(user) }

    let!(:lessor) { create(:lessor, user: user) }
    let!(:rental_agreement) { create(:rental_agreement, lessor: lessor, status: 'pending') }

    describe 'HTTP Request' do
      context 'when logged in' do
        before do
          get "/api/v1/rental_agreements/pending/#{user.id}", headers: auth
        end

        it 'return status 200' do
          expect(response).to have_http_status(:ok)
        end
      end
    end
  end
  describe 'GET /api/v1/rental_agreements/user/:id with leaseholder' do
    let(:user) { create(:user) }
    let(:auth) { auth_headers(user) }

    let(:leaseholder) { create(:leaseholder, user: user) }
    let(:lessor) { create(:lessor) }
    let!(:rental_agreement) { create(:rental_agreement, leaseholder: leaseholder, lessor: lessor, status: 'pending') }

    describe 'HTTP Request' do
      context 'when logged in' do
        before do
          get "/api/v1/rental_agreements/user/#{user.id}", headers: auth
        end

        it 'return status 200' do
          expect(response).to have_http_status(:ok)
        end
      end
    end
  end
  describe 'GET /api/v1/rental_agreements/user/:id with lessor' do
    let(:user) { create(:user) }
    let(:auth) { auth_headers(user) }

    let!(:lessor) { create(:lessor, user: user) }
    let!(:rental_agreement) { create(:rental_agreement, lessor: lessor, status: 'pending') }

    describe 'HTTP Request' do
      context 'when logged in' do
        before do
          get "/api/v1/rental_agreements/user/#{user.id}", headers: auth
        end

        it 'return status 200' do
          expect(response).to have_http_status(:ok)
        end
      end
    end
  end
  describe 'PUT /api/v1/rental_agreements/pending/approve' do
    let(:user) { create(:user) }
    let(:auth) { auth_headers(user) }
    let!(:rental_agreement) { create(:rental_agreement, status: 'pending') }

    context 'when logged in' do
      before do
        params = {
          api_v1_rental_agreement: {
            user_id: user.id,
            rental_agreement_id: rental_agreement.id
          }
        }
        put '/api/v1/rental_agreements/pending/approve', headers: auth, params: params.to_json
        rental_agreement.reload
      end

      it 'should change status to approved' do
        expect(rental_agreement.status).to eq('approved')
      end

      it 'should return ok status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end
  describe 'DELETE /api/v1/rental_agreements/pending/delete' do
    let(:user) { create(:user) }
    let(:auth) { auth_headers(user) }
    let!(:rental_agreement) { create(:rental_agreement, status: 'pending') }

    context 'when logged in' do
      before do
        params = {
          api_v1_rental_agreement: {
            user_id: user.id,
            rental_agreement_id: rental_agreement.id
          }
        }
        delete '/api/v1/rental_agreements/pending/delete', headers: auth, params: params.to_json
      end

      it 'should change status to approved' do
        expect(RentalAgreement.exists?(rental_agreement.id)).to eq(false)
      end

      it 'should return ok status' do
        expect(response).to have_http_status(:ok)
      end
    end
  end
  describe 'GET /api/v1/rental_agreements/pending/:id' do
    let(:user) { create(:user) }
    let(:auth) { auth_headers(user) }

    let!(:leaseholder) { create(:leaseholder, user: user) }
    let!(:rental_agreement) { create(:rental_agreement, leaseholder: leaseholder, status: 'pending') }

    describe 'HTTP Request' do
      context 'when logged in' do
        before do
          get "/api/v1/rental_agreements/pending/#{user.id}", headers: auth
        end

        it 'return status 200' do
          expect(response).to have_http_status(:ok)
        end

        # it 'returns a rental_agreement' do
        #   puts response.body
        # end
      end
    end
  end
  describe 'GET /api/v1/rental_agreements/:id' do
    let(:user) { create(:user) }
    let(:auth) { auth_headers(user) }

    let!(:rental_agreement) { create(:rental_agreement) }

    describe 'HTTP Request' do
      context 'when there is rental agreement' do
        before do
          get "/api/v1/rental_agreements/#{rental_agreement.id}", headers: auth
        end

        it 'return status 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'should return rental agreement' do
          parsed_response = JSON.parse(response.body)
          expect(parsed_response['RentalAgreement']['id']).to eq(rental_agreement.id)
        end
      end
      context 'when there is no rental agreement' do
        before do
          get '/api/v1/rental_agreements/a', headers: auth
        end

        it 'return status 200' do
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
  describe 'PATCH /api/v1/reviews/:id' do
    let(:user) { create(:user) }
    let(:auth) { auth_headers(user) }
    let!(:rental_agreement) { create(:rental_agreement, offer_price: 10_000) }

    context 'when logged in' do
      before do
        params = {
          api_v1_rental_agreement: {
            offer_price: 20_000
          }
        }
        patch "/api/v1/rental_agreements/#{rental_agreement.id}", headers: auth, params: params.to_json
        rental_agreement.reload
      end

      it 'return status 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns updated review score' do
        expect(rental_agreement.offer_price).to eq(20_000)
      end
    end
  end
  describe 'POST /api/v1/rental_agreements' do # rubocop:disable Metrics/BlockLength
    let(:user) { create(:user) }
    let(:auth) { auth_headers(user) }
    let!(:lessor) { create(:lessor) }
    let!(:leaseholder) { create(:leaseholder) }

    context 'when logged in' do
      before do
        params = {
          api_v1_rental_agreement: {
            timestamp_start: '2022-12-10 00:00:00',
            timestamp_end: '2022-12-11 23:00:00',
            lessor_id: lessor.id,
            leaseholder_id: leaseholder.id,
            offer_price: 5555.55,
            days_for_week: 3,
            reasons: 'just for testing'
          }
        }
        post '/api/v1/rental_agreements/', headers: auth, params: params.to_json
      end

      it 'return status 200' do
        expect(response).to have_http_status(:created)
      end

      it 'returns created rental agreement' do
        expect(RentalAgreement.last.offer_price).to eq(5555.55)
      end
    end
  end
end
