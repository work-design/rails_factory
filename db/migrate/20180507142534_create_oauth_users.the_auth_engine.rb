# This migration comes from the_auth_engine (originally 20170614071849)
class CreateOauthUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :oauth_users do |t|
      t.references :user
      t.string :provider
      t.string :type
      t.string :uid
      t.string :name
      t.string :avatar_url
      t.string :state
      t.timestamps
    end
  end
end
