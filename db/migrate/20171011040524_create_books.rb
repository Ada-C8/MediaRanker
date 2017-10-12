class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :creator
      t.date :published
      t.string :description

      t.timestamps
    end
  end
end
