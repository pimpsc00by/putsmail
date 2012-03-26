class AddSentCountToTestMail < ActiveRecord::Migration
  def change
    add_column :test_mails, :sent_count, :integer, default: 0
  end
end
