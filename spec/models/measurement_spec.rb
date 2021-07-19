require 'rails_helper'

RSpec.describe Measurement, type: :model do
  describe 'it should have the proper associations' do
    it { should belong_to(:user) }
    it { should belong_to(:unit) }
  end

  describe 'validations' do
    it { should validate_presence_of(:value) }
  end
end
