class CreateWorks < ActiveRecord::Migration[5.1]
  def change
    create_table :works do |t|
      t.string :category
      t.string :title
      t.string :creator
      t.string :published
      t.text :description

      t.timestamps
    end
  end
end
