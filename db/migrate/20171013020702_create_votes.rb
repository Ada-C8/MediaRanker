class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.string :user_id
      t.string :integer
      t.string :work_id
      t.string :integer

      t.timestamps
    end
  end
end
