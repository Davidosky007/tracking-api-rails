FactoryBot.define do
  factory :measure do
    value_of_measure { Faker::Movies::StarWars.character }
    measurement_id nil
  end
end
