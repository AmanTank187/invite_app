class AddCompositeIndexToProjectMembershipProjectUserId < ActiveRecord::Migration[8.0]
  def change
    add_index :project_memberships, [ :project_id, :user_id ], unique: true
  end
end
