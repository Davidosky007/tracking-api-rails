require 'rails_helper'

RSpec.describe 'Measurements', type: :request do
  before { post '/users', params: { name: 'patrick', password: '12345' } }
  before do
    user = User.find_by(name: 'patrick')
    unit = create(:unit)
    create_list(:measurement, 15, user: user, unit: unit)
  end
  let(:token) do
    body = JSON.parse(response.body)
    body['token']
  end
  ENV['SECRET'] = 's3cr3t' if Rails.env.test?

  describe 'GET /measurements' do
    it 'returns all the measurements of the current user for each unit' do
      get '/measurements', headers: { Authorization: "Bearer #{token}" }
      unit = Unit.last
      body = JSON.parse(response.body)
      expect(body['data'][unit.title].size).to eql(15)
    end
  end

  describe 'POST /unit/:unit_id/measurements' do
    it 'creates a new measurement that belongs to the current user and unit' do
      unit = Unit.last
      post "/units/#{unit.id}/measurements", params: { value: 123 }, headers: { Authorization: "Bearer #{token}" }
      body = JSON.parse(response.body)
      value = body['measurement']['value']
      expect(value).to eql(123.0)
      last_measurement = unit.measurements.last
      expect(value).to eql(last_measurement.value)
    end
    it 'returns an error message if the parameters are invalid' do
      unit = Unit.last
      post "/units/#{unit.id}/measurements", params: { value: '' }, headers: { Authorization: "Bearer #{token}" }
      body = JSON.parse(response.body)
      expect(body['error']).to eql('Invalid submission')
    end
  end

  describe 'PUT /units/:unit_id/measurements/:id' do
    it 'updates the value of a measurement' do
      last_measurement = Measurement.last
      id = last_measurement.id
      put("/units/#{last_measurement.unit_id}/measurements/#{id}",
          params: { value: 504 },
          headers: { Authorization: "Bearer #{token}" })
      updated_measurement = Measurement.find(id)
      expect(updated_measurement.value).to eql(504.0)
    end
  end

  describe 'DELETE /units/:unit_id/measurements/:id' do
    it 'deletes a users measurement' do
      last_measurement = Measurement.last
      id = last_measurement.id
      delete "/units/#{last_measurement.unit_id}/measurements/#{id}", headers: { Authorization: "Bearer #{token}" }
      deleted_measurement = Measurement.find_by(id: id)
      expect(deleted_measurement).to eql(nil)
    end
  end
end
