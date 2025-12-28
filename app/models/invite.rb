class Invite < ApplicationRecord
  belongs_to :project
  belongs_to :invited_by
end
