class CreateTestMails < ActiveRecord::Migration
  def change
    create_table :test_mails do |t|

      t.timestamps
    end
  end
end
