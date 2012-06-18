class AddIndexesToTestMailUsers < ActiveRecord::Migration
  def change
    add_index :test_mail_users, :test_mail_id
    add_index :test_mail_users, :user_id
  end
end
