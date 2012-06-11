class ChangeInGalleryToTestEmail < ActiveRecord::Migration
  def change
    change_column :test_mails, :in_gallery, :boolean, default: true
  end
end
