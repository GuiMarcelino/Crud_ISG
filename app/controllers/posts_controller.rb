class PostsController < ApplicationController
  before_action :authorize_request, only: [:create, :update, :destroy]
  before_action :find_post, only: [:show, :update, :destroy]

  # GET /posts
  def index
    @posts = Post.all
  end

  # GET /posts/{id}
  def show; end

  # POST /posts
  def create
    @post = @current_user.posts.new(post_params)
    if @post.save
      render json: @post, status: :created
    else
      render json: { errors: @post.errors.full_messages },
        status: :unprocessable_entity
    end
  end

  # PUT /posts/{id}
  def update
    if @post.update(post_params)
      @post
    else
      render json: { errors: @post.errors.full_messages },
        status: :unprocessable_entity
    end
  end

  # DELETE /posts/{id}
  def destroy
    @post.destroy
  end

  private

  def find_post
    @post = Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Post not found' }, status: :not_found
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
