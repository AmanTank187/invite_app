class ProjectMembership < ApplicationRecord
  belongs_to :project
  belongs_to :user

  enum :role, { viewer: "viewer", editor: "editor", admin: "admin" }, default: :viewer
end
