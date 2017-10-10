class AddIndexTrueToVotes < ActiveRecord::Migration[5.1]
  def change
    # change_column :votes, :user_id, :integer, index: true
    # change_column :votes, :work_id, :integer, index: true
    add_foreign_key :votes, :users
    add_foreign_key :votes, :works
  end
end
