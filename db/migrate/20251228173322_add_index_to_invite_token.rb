class AddIndexToInviteToken < ActiveRecord::Migration[8.0]
  def change
    add_index :invites, :token, unique: true
  end
end
