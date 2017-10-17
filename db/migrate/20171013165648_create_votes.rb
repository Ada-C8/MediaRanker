class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :work_id
      t.date :voted_on

      t.timestamps
    end
  end
end
