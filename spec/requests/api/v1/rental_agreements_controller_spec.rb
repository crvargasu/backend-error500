# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'RentalAgreements', type: :request do
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
end
