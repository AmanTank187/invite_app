class Project < ApplicationRecord
  belongs_to :creator, class_name: "User", inverse_of: :created_projects
  validates :name, presence: true

  has_many :project_memberships, dependent: :destroy
  has_many :users, through: :project_memberships
end
