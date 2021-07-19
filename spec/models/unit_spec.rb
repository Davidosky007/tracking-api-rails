require 'rails_helper'

RSpec.describe Unit, type: :model do
  describe 'associations' do
    it { should have_many(:measurements) }
  end

  describe 'validation' do
    it { should validate_presence_of(:title) }
  end
end
