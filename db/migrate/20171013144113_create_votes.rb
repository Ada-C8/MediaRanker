class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.author_id
      t.work_id

      t.timestamps
    end
  end
end
