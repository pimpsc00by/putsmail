class AddInGalleryToTestMail < ActiveRecord::Migration
  def change
    add_column :test_mails, :in_gallery, :boolean, default: false
  end
end
