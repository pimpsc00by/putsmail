class AddMakeCssInlineToTestMails < ActiveRecord::Migration
  def change
    add_column :test_mails, :make_css_inline, :boolean, default: true
  end
end
