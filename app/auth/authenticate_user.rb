class AuthenticateUser
  def initialize(email, password)
    @email = email
    @password = password
  end

  # Service entry point
  def call
    JsonWebToken.encode(name: user.name, email: user.email, user_id: user.id) if user
  end

  private

  attr_reader :email, :password

  # verify user credentials
  def user
    User.find_by(email: email)

    # raise Authentication error if credentials are invalid
    # raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end
end
