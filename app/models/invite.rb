class Invite < ApplicationRecord
  belongs_to :project
  belongs_to :invited_by, class_name: "User"

  validates :project_id,
  uniqueness: {
    scope: :email,
    conditions: -> { where(accepted_at: nil) }
  }

  normalizes :email, with: ->(email) { email.to_s.strip.downcase }
  enum :role, { viewer: "viewer", editor: "editor", admin: "admin" }
end
