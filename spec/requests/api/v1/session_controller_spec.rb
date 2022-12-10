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
  describe 'login with leaseholder user' do
    let!(:url) { '/users/sign_in' }
    let!(:email) { 'email@domain.code' }
    let!(:password) { '123123123' }

    context 'when attempting login with correct credentials' do
      let!(:correct_params) { login_params(email, password) }
      let!(:user) { create(:user, email: email, password: password) }
      let!(:leaseholder) { create(:leaseholder, user: user) }

      before do
        post url, params: correct_params
      end

      it 'should be successful' do
        expect(response).to be_successful
      end

      it 'should return correct user' do
        expect(JSON.parse(response.body)['user']['id'].to_i).to eq(user.id)
      end

      it 'should return correct leaseholder' do
        expect(JSON.parse(response.body)['other']['id'].to_i).to eq(leaseholder.id)
      end
    end
  end
  describe 'login with lessor user' do
    let!(:url) { '/users/sign_in' }
    let!(:email) { 'email@domain.code' }
    let!(:password) { '123123123' }

    context 'when attempting login with correct credentials' do
      let!(:correct_params) { login_params(email, password) }
      let!(:user) { create(:user, email: email, password: password) }
      let!(:lessor) { create(:lessor, user: user) }

      before do
        post url, params: correct_params
      end

      it 'should be successful' do
        expect(response).to be_successful
      end

      it 'should return correct user' do
        expect(JSON.parse(response.body)['user']['id'].to_i).to eq(user.id)
      end

      it 'should return correct lessor' do
        expect(JSON.parse(response.body)['other']['id'].to_i).to eq(lessor.id)
      end
    end
  end
  describe 'login with lessor user' do
    let!(:url) { '/users/sign_in' }
    let!(:email) { 'email@domain.code' }
    let!(:password) { '123123123' }

    context 'when attempting login with correct credentials' do
      let!(:correct_params) { login_params(email, password) }
      let!(:user) { create(:user, email: email, password: password, role: 'admin') }

      before do
        post url, params: correct_params
      end

      it 'should be successful' do
        expect(response).to be_successful
      end

      it 'should return correct user' do
        expect(JSON.parse(response.body)['user']['id'].to_i).to eq(user.id)
      end

      it 'should return correct lessor' do
        expect(JSON.parse(response.body)['user']['role']).to eq('admin')
      end
    end
  end
end
