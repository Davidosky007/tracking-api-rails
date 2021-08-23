class Measure < ApplicationRecord
  belongs_to :measurement

  # validation
  validates_presence_of :value_of_measure
end
