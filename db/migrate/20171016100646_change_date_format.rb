class ChangeDateFormat < ActiveRecord::Migration[5.1]
  def change
    change_column(:votes, :created_at, :date)
  end
end
