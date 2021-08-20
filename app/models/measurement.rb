class Measurement < ApplicationRecord
  has_many :measures, dependent: :destroy
  validates_presence_of :name, :created_by
end
