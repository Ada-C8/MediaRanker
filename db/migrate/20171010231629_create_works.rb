class CreateWorks < ActiveRecord::Migration[5.1]
  def change
    create_table :works do |t|
      t.string :category
      t.string :title
      t.string :creator
      t.integer :publication_year
      t.integer :description

      t.timestamps
    end
  end
end
