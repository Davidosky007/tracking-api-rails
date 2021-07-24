class User < ApplicationRecord
  has_secure_password
  has_many :measurements, dependent: :destroy

  validates_presence_of :email
  validates_uniqueness_of :email
end
