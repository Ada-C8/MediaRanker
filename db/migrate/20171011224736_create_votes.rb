class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.date :date

      t.timestamps
    end
  end
end
