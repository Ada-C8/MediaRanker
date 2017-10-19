class CreateWorks < ActiveRecord::Migration[5.1]
  def change
    create_table :works do |t|
      t.string :title
      t.string :creator
      t.string :description
      t.date :publication_date
      t.string :category

      t.timestamps
    end
  end
end
