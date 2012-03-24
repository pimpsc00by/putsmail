class AddSubjectAndBodyToTestMail < ActiveRecord::Migration
  def change
    add_column :test_mails, :subject, :string
    add_column :test_mails, :body, :text
  end
end
