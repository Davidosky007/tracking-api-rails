class UsersController < ApplicationController
  before_action :authorized, except: %i[create login show]

  def create
    @user = User.new(user_params)
    if @user.save
      token = encode_token({ user_id: @user.id })
      render json: { token: token }
    else
      render json: { error: 'Invalid username or password', status: 400 }, status: 400
    end
  end

  def login
    @user = User.find_by(name: params[:name])

    if @user&.authenticate(params[:password])
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token }
    else
      render json: { error: 'Invalid username or password', status: 400 }, status: 400
    end
  end

  private

  def user_params
    params.permit(:name, :password)
  end
end
