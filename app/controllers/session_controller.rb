class SessionController < ApplicationController
  def create
    @user = User.find_by(name: params[:name])

    if @user&.authenticate(params[:password])
      token = encode_token({ user_id: @user.id })
      render json: { token: token }
    else
      render json: { error: 'Invalid username or password', status: 401 }, status: 401
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
