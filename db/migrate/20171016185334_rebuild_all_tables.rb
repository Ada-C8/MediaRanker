class RebuildAllTables < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name

      t.timestamps
    end

    create_table :works do |t|
      t.string :title
      t.string :category
      t.integer :publication_year
      t.text :description
      t.string :creator

      t.timestamps
    end

    create_table :votes do |t|
      t.integer "work_id"
      t.integer "user_id"
      t.timestamps

    end
  end
end
