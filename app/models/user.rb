class User < ApplicationRecord
  normalizes :email, with: ->(email) { email.to_s.strip.downcase }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  has_many :created_projects,
           class_name: "Project",
           foreign_key: :creator_id,
           inverse_of: :creator
end
