class AddIndexToUsersEmail < ActiveRecord::Migration[8.0]
  def change
    add_index :users, "lower(email)", unique: true
  end
end
