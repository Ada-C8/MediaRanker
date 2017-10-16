class AddWorkAndUserReferenceToVotes < ActiveRecord::Migration[5.1]
  def change
    add_column( :votes, :work_id, :integer )
    add_column( :votes, :user_id, :integer )
  end
end
