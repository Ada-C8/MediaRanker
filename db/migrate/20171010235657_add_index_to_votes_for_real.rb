class AddIndexToVotesForReal < ActiveRecord::Migration[5.1]
  def change
    add_index :votes, :user_id
    add_index :votes, :work_id
  end
end
