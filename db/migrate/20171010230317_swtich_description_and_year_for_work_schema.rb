class SwtichDescriptionAndYearForWorkSchema < ActiveRecord::Migration[5.1]
  def change
    rename_column :works, :description, :publicaton_year
    rename_column :works, :year, :description
  end
end
