class CreateInvites < ActiveRecord::Migration[8.0]
  def change
    create_table :invites do |t|
      t.references :project, null: false, foreign_key: true
      t.string :email, null: false
      t.string :role, null: false
      t.string :token, null: false, default: "gen_random_uuid()"
      t.references :invited_by, null: false, foreign_key: { to_table: :users }
      t.datetime :accepted_at

      t.timestamps
    end
  end
end
