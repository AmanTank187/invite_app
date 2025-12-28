class Invite < ApplicationRecord
  belongs_to :project
  belongs_to :invited_by, class_name: "User"

  normalizes :email, with: ->(email) { email.to_s.strip.downcase }
end
