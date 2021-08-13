class Measurement < ApplicationRecord
  belongs_to :user
  belongs_to :unit

  scope :with_units, -> { includes(:unit) }
  scope :created_on, -> { order('created_at DESC') }

  validates :value, presence: true
  def new_data
    @measurements = current_user.measurements.with_units.created_on
    data = Hash.new { |h, k| h[k] = [] }
    @measurements.each do |m|
      data[m.unit.title] << m
    end
  end
end
