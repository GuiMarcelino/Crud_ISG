# spec/controllers/posts_controller_spec.rb

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { create(:user) }
  let(:token_data) { JsonWebToken.encode(user_id: user.id) }
  let(:token) { token_data[:token] }
  let(:post_instance) { create(:post, user: user) }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: post_instance.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    let(:valid_params) do
      {
        post: {
          title: 'Post Title',
          text: 'Post Text',
          user_id: user.id
        }
      }
    end

    let(:invalid_params) do
      {
        post: {
          title: nil,
          text: nil
        }
      }
    end

    context "with valid parameters" do
      context "when user is authenticated" do
        before { request.headers['Authorization'] = "Bearer #{token}" }

        it "creates a new post" do
          expect { post :create, params: valid_params }.to change(Post, :count).by(1)
        end

        it "returns a 201 status code" do
          post :create, params: valid_params
          expect(response).to have_http_status(201)
        end
      end

      context "when user is not authenticated" do
        it "does not create a new post" do
          expect { post :create, params: valid_params }.not_to change(Post, :count)
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
          }.to_not change(Post, :count)
        end

        it "returns a 422 status code" do
          post :create, params: invalid_params
          expect(response).to have_http_status(422)
        end
      end

      context "when user is not authenticated" do
        it "does not create a new post" do
          expect { post :create, params: invalid_params }.not_to change(Post, :count)
        end

        it "returns a 401 status code" do
          post :create, params: invalid_params
          expect(response).to have_http_status(401)
        end
      end
    end
  end

  describe 'PUT #update' do
    let(:new_params) { { title: 'New Title' } }

    before do
      request.headers['Authorization'] = "Bearer #{token}"
    end

    it "updates the post" do
      put :update, params: { id: post_instance.id, post: new_params }
      expect(post_instance.reload.title).to eq('New Title')
    end

    it "returns a 200 status code" do
      put :update, params: { id: post_instance.id, post: new_params }
      expect(response).to have_http_status(200)
    end
  end

  describe 'DELETE #destroy' do
    before do
      request.headers['Authorization'] = "Bearer #{token}"
      post_instance # Create the post before the expectation
    end

    it "deletes the post" do
      expect {
        delete :destroy, params: { id: post_instance.id }
      }.to change(Post, :count).by(-1)
    end

    it "returns a 200 status code" do
      delete :destroy, params: { id: post_instance.id }
      expect(response).to have_http_status(200)
    end
  end
end