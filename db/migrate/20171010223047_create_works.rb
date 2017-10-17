class CreateWorks < ActiveRecord::Migration[5.1]
  def change
    create_table :works do |t|
      t.references :category, foreign_key: true
      t.string :title
      t.string :creator
      t.integer :publication_year
      t.text :description

      t.timestamps
    end
  end
end
