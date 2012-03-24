class TestMail < ActiveRecord::Base
  has_many :test_mail_users
  
  has_many :users, :through => :test_mail_users
  
  after_update :send_test_mails
    
  def to_json(options={})
    super(:include => [:users])
  end
  
  private
  def send_test_mails
    unless self.users.empty?
      TestMailMailer.test_mail(self).deliver
    end
  end
end
