class AddOauthUidAndProvider < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :oauth_uid, :string
    add_column :users, :oauth_provider, :string
  end
end
