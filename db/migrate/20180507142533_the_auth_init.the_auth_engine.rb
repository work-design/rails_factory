# This migration comes from the_auth_engine (originally 20170518023400)
class TheAuthInit < ActiveRecord::Migration[5.1]
  def change

    create_table :users do |t|
      t.string :name, limit: 100
      t.string :avatar
      t.string :email, limit: 100
      t.boolean :email_confirm, default: false
      t.string :mobile, limit: 20
      t.boolean :mobile_confirm, default: false
      t.string :password_digest
      t.datetime :last_login_at
      t.string :last_login_ip
      t.boolean :disabled, default: false
      t.timestamps
    end

    create_table :verify_tokens do |t|
      t.references :user
      t.string :type, limit: 100
      t.string :token
      t.datetime :expired_at
      t.string :account
      t.integer :access_counter, default: 0
      t.timestamps
    end

  end
end

