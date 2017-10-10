class CreateWorks < ActiveRecord::Migration[5.1]
  def change
    create_table :works do |t|
      t.string :title
      t.string :category
      t.string :creator
      t.string :year
      t.text :desc

      t.timestamps
    end
  end
end
