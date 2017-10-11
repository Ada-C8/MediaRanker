class CreateWorks < ActiveRecord::Migration[5.1]
  def change
    create_table :works do |t|
      t.string :title
      t.string :description
      t.string :creator
      t.integer :year

      t.timestamps
    end
  end
end
