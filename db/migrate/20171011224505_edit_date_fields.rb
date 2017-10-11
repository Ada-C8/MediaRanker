class EditDateFields < ActiveRecord::Migration[5.1]
  def change
    remove_column(:users, :updated_at)
    remove_column(:users, :join_date)
    rename_column(:users, :created_at, :join_date)

    remove_column(:votes, :updated_at)
    remove_column(:votes, :date)
    rename_column(:votes, :created_at, :date)

    remove_column(:works, :updated_at)
    remove_column(:works, :created_at)
  end
end
