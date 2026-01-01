class Invite < ApplicationRecord
  belongs_to :project
  belongs_to :invited_by, class_name: "User"

  validate :check_user_membership

  validates :project_id,
  uniqueness: {
    scope: :email,
    conditions: -> { where(accepted_at: nil) }
  }

  normalizes :email, with: ->(email) { email.to_s.strip.downcase }
  enum :role, { viewer: "viewer", editor: "editor", admin: "admin" }

  private

  def check_user_membership
    if project.users.exists?(email: email)
      errors.add(:base, "User is already a member of this project")
    end
  end
end
