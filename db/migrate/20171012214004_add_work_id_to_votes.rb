class AddWorkIdToVotes < ActiveRecord::Migration[5.1]
  def change
    add_column :votes, :work_id, :integer
  end
end
