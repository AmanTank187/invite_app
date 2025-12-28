class Project < ApplicationRecord
  belongs_to :creator, class_name: "User", inverse_of: :created_projects
  validates :name, presence: true
end
