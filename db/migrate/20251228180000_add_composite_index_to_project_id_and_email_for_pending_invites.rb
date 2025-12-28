class AddCompositeIndexToProjectIdAndEmailForPendingInvites < ActiveRecord::Migration[8.0]
  def change
    add_index :invites,
      [ :project_id, :email ],
      unique: true,
      where: "accepted_at IS NULL",
      name: "index_invites_unique_pending"
  end
end
