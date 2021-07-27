require 'rails_helper'

RSpec.describe 'Users', type: :request do
  before { post '/users', params: { name: 'example', password: '12345' } }
  ENV['SECRET'] = 's3cr3t' if Rails.env.test?
  describe 'POST /users' do
    it 'creates a new user' do
      post '/users', params: { name: 'patrick', password: '12345' }
      user = User.last
      expect(user.name).to eql('patrick')
    end
    it 'returns error message if the name or password is invalid' do
      post '/users', params: { name: 'bob', password: '' }
      body = JSON.parse(response.body)
      expect(body['error']).to eql('Invalid username or password')
    end
    it 'return error message if the username is taken' do
      post '/users', params: { name: 'example', password: '12345' }
      body = JSON.parse(response.body)
      expect(body['error']).to eql('Invalid username or password')
    end
  end

  describe 'POST /login' do
    it 'logins the user' do
      post '/login', params: { name: 'example', password: '12345' }
      body = JSON.parse(response.body)
      expect(body['user']['name']).to eql('example')
    end
    it 'return error message if wrong username or password is given' do
      post '/login', params: { name: 'wrongName', password: '12345' }
      body = JSON.parse(response.body)
      expect(body['error']).to eql('Invalid username or password')
    end
  end
end
