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

        # it 'returns a rental_agreement' do
        #   puts response.body
        # end
      end
    end
  end
end
