# spec/controllers/comments_controller_spec.rb

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:post_instance) { create(:post, user: user) }
  let(:comment) { create(:comment, post: post_instance) }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: comment.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    let(:valid_params) do
      {
        comment: {
          name: FFaker::NameBR.name,
          comment: FFaker::Lorem.word,
          post_id: post_instance.id
        }
      }
    end

    let(:invalid_params) do
      {
        comment: {
          name: nil,
          comment: nil,
          post_id: nil
        }
      }
    end

    context 'with valid parameters' do
      it 'creates a new comment' do
        expect {
          post :create, params: valid_params
        }.to change(Comment, :count).by(1)
      end

      it 'returns a 201 status code' do
        post :create, params: valid_params
        expect(response).to have_http_status(201)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new comment' do
        expect {
          post :create, params: invalid_params
        }.to_not change(Comment, :count)
      end

      it 'returns a 422 status code' do
        post :create, params: invalid_params
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT #update' do
    let(:new_params) { { comment: 'Test comment' } }

    it 'updates the comment' do
      put :update, params: { id: comment.id, comment: new_params }
      expect(comment.reload.comment).to eq('Test comment')
    end

    it 'returns a 200 status code' do
      put :update, params: { id: comment.id, comment: new_params }
      expect(response).to have_http_status(200)
    end
  end

  describe 'DELETE #destroy' do
    before do
      comment
    end

    it 'deletes the comment' do
      expect {
        delete :destroy, params: { id: comment.id }
      }.to change(Comment, :count).by(-1)
    end

    it 'returns a 200 status code' do
      delete :destroy, params: { id: comment.id }
      expect(response).to have_http_status(200)
    end
  end
end
