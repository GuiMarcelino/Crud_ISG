class UsersController < ApplicationController
  before_action :authorize_request, only: [:create, :update, :destroy]
  before_action :find_user, only: %i[show update destroy]

  # GET /users
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  # GET /users/{id}
  def show
    render json: @user, status: :ok
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
        status: :unprocessable_entity
    end
  end

  # PUT /users/{id}
  def update
    unless @user.update(user_params)
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    else
      render json: @user, status: :ok
    end
  end

  # DELETE /users/{id}
  def destroy
    @user.destroy
    render json: { message: 'User deleted' }, status: :ok
  end

  private

  def find_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password_digest
    )
  end
end
