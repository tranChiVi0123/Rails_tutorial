class User < ApplicationRecord
  before_save{email.downcase!}
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness:  true

  has_secure_password
  validates :password, presence: true, length: {minimum: 6}

  # Returns the hash digest of the given string.
  def self.digest _string
    cost = ActiveModel::SecurePassword.min_cost ? Bcrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
