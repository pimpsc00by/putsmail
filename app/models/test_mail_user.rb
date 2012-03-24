class TestMailUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :test_mail
  
  validates_presence_of :user_id
  validates_presence_of :test_mail_id
  
  validates_uniqueness_of :user_id, :scope => [:test_mail_id]
end
