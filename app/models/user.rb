class User < ApplicationRecord
  normalizes :email, with: ->(email) { email.to_s.strip.downcase }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
end
