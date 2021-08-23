class User < ApplicationRecord
  # encrypt password
  has_secure_password
  validates_uniqueness_of :name, :email

  # Model associations
  has_many :measurements, foreign_key: :created_by
  # Validations
  validates_presence_of :name, :email, :password_digest
end
