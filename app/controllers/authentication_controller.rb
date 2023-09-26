class AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login

  # POST /auth/login
  def login
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token_data = JsonWebToken.encode(user_id: @user.id)
      render json: {
        token: token_data[:token],
        exp: Time.at(token_data[:exp]).
          strftime("%m-%d-%Y %H:%M:%S") }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
