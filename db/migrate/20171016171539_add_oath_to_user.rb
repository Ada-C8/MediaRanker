class AddOathToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :username, :string
    add_column :users, :email, :string
    add_column :users, :provider, :string, null: false
    add_column :users, :uid, :string, null: false
  end
end
