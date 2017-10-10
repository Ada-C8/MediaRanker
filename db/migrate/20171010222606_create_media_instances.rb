class CreateMediaInstances < ActiveRecord::Migration[5.1]
  def change
    create_table :media_instances do |t|
      t.string :media_type
      t.string :title
      t.string :creator
      t.integer :pub_yr
      t.string :description

      t.timestamps
    end
  end
end
