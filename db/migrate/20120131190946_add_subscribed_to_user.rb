class AddSubscribedToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :subscribed, :boolean
    
    User.update_all(:subscribed => true)
  end

  def self.down
    remove_column :users, :subscribed
  end
end
