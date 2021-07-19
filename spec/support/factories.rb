require 'rails_helper'

FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "Name#{n}" }
    password { '123456' }
  end

  factory :unit do
    sequence(:title) { |n| "Unit#{n}" }
  end

  factory :measurement do
    user { create :user }
    unit { create :unit }
    value { rand * 10.round }
  end
end
