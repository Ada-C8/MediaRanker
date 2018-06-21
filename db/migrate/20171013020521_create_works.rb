class CreateWorks < ActiveRecord::Migration[5.1]
  def change
    create_table :works do |t|
      t.string :category
      t.string :string
      t.string :title
      t.string :string
      t.string :pub_year
      t.string :integer
      t.string :description
      t.string :string

      t.timestamps
    end
  end
end
