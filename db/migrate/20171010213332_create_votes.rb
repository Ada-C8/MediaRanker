class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.date :date
      t.integer :user_id
      t.integer :work_id

      t.timestamps
    end
  end
end
