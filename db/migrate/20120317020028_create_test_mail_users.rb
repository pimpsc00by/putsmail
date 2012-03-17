class CreateTestMailUsers < ActiveRecord::Migration
  def change
    create_table :test_mail_users do |t|
      t.integer :test_email_id
      t.integer :user_id

      t.timestamps
    end
  end
end
