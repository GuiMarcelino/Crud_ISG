# spec/controllers/authentication_controller_spec.rb

require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
  let(:user) { create(:user, password: 'password123', password_confirmation: 'password123') }

  describe 'POST #login' do
    context 'with valid credentials' do
      let(:params) { { email: user.email, password: 'password123' } }

      it 'returns a JWT token' do
        post :login, params: params
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key('token')
      end

      it 'returns an expiration time' do
        post :login, params: params
        json_response = JSON.parse(response.body)
        expect(json_response).to have_key('exp')
      end

      it 'returns a 200 status code' do
        post :login, params: params
        expect(response).to have_http_status(200)
      end
    end

    context 'with invalid credentials' do
      let(:params) { { email: user.email, password: 'wrong_password' } }

      it 'returns an error message' do
        post :login, params: params
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq('unauthorized')
      end

      it 'returns a 401 status code' do
        post :login, params: params
        expect(response).to have_http_status(401)
      end
    end

    context 'with missing email' do
      let(:params) { { password: 'password123' } }

      it 'returns a 401 status code' do
        post :login, params: params
        expect(response).to have_http_status(401)
      end
    end

    context 'with missing password' do
      let(:params) { { email: user.email } }

      it 'returns a 401 status code' do
        post :login, params: params
        expect(response).to have_http_status(401)
      end
    end
  end
end
