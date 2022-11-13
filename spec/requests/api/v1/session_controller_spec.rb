# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Session routes', type: :request do # rubocop:disable Metrics/BlockLength
  describe 'login' do # rubocop:disable Metrics/BlockLength
    let!(:url) { '/users/sign_in' }
    let!(:email) { 'email@domain.code' }
    let!(:password) { '123123123' }

    describe 'HTTP request' do
      context 'when attempting login with correct credentials' do
        let!(:correct_params) { login_params(email, password) }

        before do
          User.create(email: email, password: password)
          post url, params: correct_params
        end

        it 'should be successful' do
          expect(response).to be_successful
        end

        it 'should have authorization header' do
          expect(response.headers['Authorization']).to be_present
        end
      end

      context 'when attempting login with incorrect credentials' do
        let!(:incorrect_params) { login_params('', '') }

        before do
          post url, params: incorrect_params
        end

        it 'should not be successful' do
          expect(response).not_to be_successful
        end
      end
    end

    describe 'behavior' do
      context 'when attempting login with correct credentials' do
        let!(:user) { create(:user) }
        let!(:correct_params) { login_params(user.email, user.password) }

        before do
          post url, params: correct_params
        end

        it 'should be successful' do
          expect(controller.current_user).to eq(user)
        end
      end

      context 'when attempting login with incorrect credentials' do
        let!(:incorrect_params) { login_params('', '') }

        before do
          post url, params: incorrect_params
        end

        it 'should be empty' do
          expect(controller).to be_a Devise::FailureApp
        end
      end
    end
  end
end
