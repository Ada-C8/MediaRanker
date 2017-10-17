class RemoveDateColumnFromVotes < ActiveRecord::Migration[5.1]
  def change
    remove_column :votes, :date
  end
end
