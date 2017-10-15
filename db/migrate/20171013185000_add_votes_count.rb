class AddVotesCount < ActiveRecord::Migration[5.1]
  def change
    add_column :works, :vote_count, :integer , :default => 0
    Work.reset_column_information
    Work.all.each do |work|
      Work.update_counters work.id, :vote_count => work.vote_count
    end
  end
end 
