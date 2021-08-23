# spec/models/Measurement_spec.rb
# require 'rails_helper'

# Test suite for the Measurement model
RSpec.describe Measurement, type: :model do
  # Association test
  # ensure Measurement model has a 1:m relationship with the Item model
  it { should have_many(:measures).dependent(:destroy) }
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:created_by) }
end
