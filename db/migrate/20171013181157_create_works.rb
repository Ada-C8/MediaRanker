class CreateWorks < ActiveRecord::Migration[5.1]
  def change
    create_table :works do |t|
      t.string :category, null: false
      t.string :title, null: false
      t.string :creator, null: false
      t.string :published, null: false
      t.text :description

      t.timestamps
    end
  end
end
