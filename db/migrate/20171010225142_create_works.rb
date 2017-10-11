class CreateWorks < ActiveRecord::Migration[5.1]
  def change
    create_table :works do |t|
      t.string :category
      t.string :title
      t.integer :publication_year
      t.text :description

      t.timestamps
    end
  end
end
