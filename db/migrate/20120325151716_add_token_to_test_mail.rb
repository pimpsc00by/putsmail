class AddTokenToTestMail < ActiveRecord::Migration
  def change
    add_column :test_mails, :token, :string
    add_index :test_mails, :token, unique: true
  end
end
