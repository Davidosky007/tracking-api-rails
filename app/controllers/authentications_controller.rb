class AuthenticationsController < ApplicationController
  # return auth token once user is authenticated
  skip_before_action :authorize_request, only: :create

  def create
    auth_token =
      AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    json_response(auth_token: auth_token)
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
