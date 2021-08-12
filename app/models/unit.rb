class Unit < ApplicationRecord
  has_many :measurements

  scope :with_measurements, -> { includes(:measurements) }
  scope :with_user_id, ->(user) { where(user_id: user.id) }

  validates :title, presence: true
end
