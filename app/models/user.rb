class User < ApplicationRecord
  normalizes :email, with: ->(email) { email.to_s.strip.downcase }
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  has_many :project_memberships, dependent: :destroy
  has_many :projects, through: :project_memberships
end
