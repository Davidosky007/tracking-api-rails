# spec/requests/measurements_spec.rb
# require 'rails_helper'

RSpec.describe 'measurements API', type: :request do
  # initialize test data
  let(:user) { create(:user) }
  let!(:measurements) { create_list(:measurement, 10, created_by: user.id) }
  let(:measurement_id) { measurements.first.id }
  # authorize request
  let(:headers) { valid_headers }

  # Test suite for GET /measurements
  describe 'GET /measurements' do
    # make HTTP get request before each example
    before { get '/measurements', params: {}, headers: headers }

    it 'returns measurements' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /measurements/:id
  describe 'GET /measurements/:id' do
    before { get "/measurements/#{measurement_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the measurement' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(measurement_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:measurement_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/"message":"Couldn't find Measurement with 'id'=100"/)
      end
    end
  end

  # Test suite for POST /measurements
  describe 'POST /measurements' do
    # valid payload
    let(:valid_attributes) { { name: 'Learn Elm', created_by: user.id.to_s }.to_json }

    context 'when the request is valid' do
      before { post '/measurements', params: valid_attributes, headers: headers }

      it 'creates a measurement' do
        expect(json['name']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { name: nil }.to_json }

      before { post '/measurements', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message'])
          .to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  describe 'PUT /measurements/:id' do
    let(:valid_attributes) { { name: 'Shopping' }.to_json }

    context 'when the record exists' do
      before { put "/measurements/#{measurement_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /measurements/:id' do
    before { delete "/measurements/#{measurement_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
