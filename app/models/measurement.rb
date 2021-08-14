class Measurement < ApplicationRecord
  belongs_to :user
  belongs_to :unit

  scope :with_units, -> { includes(:unit) }
  scope :created_on, -> { order('created_at DESC') }

  validates :value, presence: true
end
