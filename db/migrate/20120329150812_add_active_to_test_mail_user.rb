class AddActiveToTestMailUser < ActiveRecord::Migration
  def change
    add_column :test_mail_users, :active, :boolean, default: true
  end
end
