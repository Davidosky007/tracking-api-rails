require 'rails_helper'
require_relative '../support/factories'

RSpec.describe 'Units', type: :request do
  before { create_list(:unit, 10) }
  before { post '/users', params: { username: 'patrick', password: '12345' } }
  ENV['SECRET'] = 's3cr3t' if Rails.env.test?

  describe 'GET /units' do
    it 'returns a list with all available units to track if a user is logged in' do
      body = JSON.parse(response.body)
      token = body['token']
      get '/units', headers: { Authorization: "Bearer #{token}" }
      json = JSON.parse(response.body)
      expect(json).to_not be_empty
      expect(json['units'].size).to eql(10)
    end
    it 'return an error message if the user in not logged in or anuthorized' do
      get '/units'
      json = JSON.parse(response.body)
      expect(json['message']).to eql('Please log in')
    end
  end

  describe 'Get /units/:id' do
    it "returns the unit and all it's measurments made by a user" do
      user = User.first
      create(:measurement, user: user)
      body = JSON.parse(response.body)
      token = body['token']
      unit = Unit.last
      get "/units/#{unit.id}", headers: { Authorization: "Bearer #{token}" }
      body = JSON.parse(response.body)
      expect(body['unit']['id']).to eql(unit.id)
      expect(body['measurements'].size).to eql(1)
    end
  end
end
