class CreateAlbums < ActiveRecord::Migration[5.1]
  def change
    create_table :albums do |t|
      t.string :title
      t.string :creator
      t.date :published
      t.string :description

      t.timestamps
    end
  end
end
