class Measurement < ApplicationRecord
  belongs_to :user
  belongs_to :unit

  scope :with_units, -> { includes(:unit) }
  scope :created_on, -> { order('created_at DESC') }
  scope :filter_by_unit, ->(unit_id) { where(unit_id: unit_id) }

  validates :value, presence: true
end
