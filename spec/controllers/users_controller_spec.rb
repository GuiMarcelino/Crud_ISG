# spec/controllers/users_controller_spec.rb

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:token_data) { JsonWebToken.encode(user_id: user.id) }
  let(:token) { token_data[:token] }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, format: :json
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: user.id }, format: :json
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    let(:valid_params) do
      {
        user: {
          name: FFaker::NameBR.name,
          email: 'john@example.com',
          password_digest: 'Test@123!!!'
        }
      }
    end

    let(:invalid_params) do
      {
        user: {
          name: nil,
          email: nil,
          password_digest: nil
        }
      }
    end

    context "with valid parameters" do
      context "when user is authenticated" do
        before do
          request.headers['Authorization'] = "Bearer #{token}"
        end

        it "creates a new user" do
          expect {
            post :create, params: valid_params
          }.to change(User, :count).by(1)
        end

        it "returns a 201 status code" do
          post :create, params: valid_params
          expect(response).to have_http_status(201)
        end
      end

      context "when user is not authenticated" do
        it "does not create a new user" do
          expect {
            post :create, params: valid_params
          }.to_not change(User, :count)
        end

        it "returns a 401 status code" do
          post :create, params: valid_params
          expect(response).to have_http_status(401)
        end
      end
    end

    context "with invalid parameters" do
      context "when user is authenticated" do
        before do
          request.headers['Authorization'] = "Bearer #{token}"
        end

        it "does not create a new user" do
          expect {
            post :create, params: invalid_params
          }.to_not change(User, :count)
        end

        it "returns a 422 status code" do
          post :create, params: invalid_params
          expect(response).to have_http_status(422)
        end
      end

      context "when user is not authenticated" do
        it "does not create a new user" do
          expect {
            post :create, params: invalid_params
          }.to_not change(User, :count)
        end

        it "returns a 401 status code" do
          post :create, params: invalid_params
          expect(response).to have_http_status(401)
        end
      end
    end
  end

  describe 'PUT #update' do
    let(:new_params) { { user: { name: 'New Name' } } }

    context "when user is authenticated" do
      before do
        request.headers['Authorization'] = "Bearer #{token}"
      end

      it 'updates the user' do
        put :update, params: { id: user.id }.merge(new_params), format: :json
        expect(user.reload.name).to eq('New Name')
      end

      it 'returns a 200 status code' do
        put :update, params: { id: user.id }.merge(new_params), format: :json
        expect(response).to have_http_status(200)
      end
    end

    context "when user is not authenticated" do
      it 'does not update the user' do
        put :update, params: { id: user.id }.merge(new_params)
        expect(user.reload.name).not_to eq('New Name')
      end

      it 'returns a 401 status code' do
        put :update, params: { id: user.id }.merge(new_params)
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'DELETE #destroy' do
    context "when user is authenticated" do
      before do
        request.headers['Authorization'] = "Bearer #{token}"
      end

      it 'deletes the user' do
        expect {
          delete :destroy, params: { id: user.id }, format: :json
        }.to change(User, :count).by(-1)
      end

      it 'returns a 200 status code' do
        delete :destroy, params: { id: user.id }, format: :json
        expect(response).to have_http_status(200)
      end
    end

    context "when user is not authenticated" do
      before do
        user
      end

      it 'does not delete the user' do
        expect {
          delete :destroy, params: { id: user.id }
        }.to_not change(User, :count)
      end

      it 'returns a 401 status code' do
        delete :destroy, params: { id: user.id }
        expect(response).to have_http_status(401)
      end
    end
  end
end
