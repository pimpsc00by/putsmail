class AddUserIdToTestMails < ActiveRecord::Migration
  def change
    add_column :test_mails, :user_id, :integer
  end
end
