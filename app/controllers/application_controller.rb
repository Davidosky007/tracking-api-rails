class ApplicationController < ActionController::API
  before_action :authorized

  def encode_token(payload)
    secret = ENV['SECRET']
    JWT.encode(payload, secret)
  end

  def auth_header
    # { Authorization: 'Bearer <token>' }
    request.headers['Authorization']
  end

  def decoded_token
    return unless auth_header

    token = auth_header.split[1]
    # header: { 'Authorization': 'Bearer <token>' }
    begin
      secret = f1d641d9920cda278133396844a5c5b7d648015a526b709a342277d66c12558f41c7e76db37de7d74e80777a5ebe2e938ae899633ed18c98800f1b650b830dc6
      JWT.decode(token, secret, true, algorithm: 'HS256')
    rescue JWT::DecodeError
      nil
    end
  end

  def logged_in_user
    return unless decoded_token

    user_id = decoded_token[0]['user_id']
    @user = User.find_by(id: user_id)
  end

  def logged_in?
    !!logged_in_user
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end

  def current_user
    @user
  end
end
