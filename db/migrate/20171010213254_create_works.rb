class CreateWorks < ActiveRecord::Migration[5.1]
  def change
    create_table :works do |t|
      # t.category :string
      # t.title :string
      # t.creator :string
      # t.publication_year :integer
      # t.description :text

      t.string :category
      t.string :title
      t.string :creator
      t.integer :publication_year
      t.text :description

      t.timestamps
    end
  end
end
