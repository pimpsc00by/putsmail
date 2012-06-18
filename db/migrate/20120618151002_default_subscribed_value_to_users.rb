class DefaultSubscribedValueToUsers < ActiveRecord::Migration
  def up
    change_column :users, :subscribed, :boolean, default: true    
  end
end
