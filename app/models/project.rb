class Project < ApplicationRecord
  validates :name, presence: true

  has_many :project_memberships, dependent: :destroy
  has_many :users, through: :project_memberships
end
