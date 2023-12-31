class UsersController < ApplicationController
  before_action :authorize_request, only: [:create, :update, :destroy]
  before_action :find_user, only: %i[show update destroy]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/{id}
  def show; end

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
    if @user.update(user_params)
      @user
    else
      render json: { errors: @user.errors.full_messages },
        status: :unprocessable_entity
    end
  end

  # DELETE /users/{id}
  def destroy
    @user.destroy
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
