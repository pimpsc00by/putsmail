require 'email_format_validator'
class User < ActiveRecord::Base  
  validates :mail, :uniqueness => true, :allow_nil => :false, :email_format => true, :allow_blank => false
  
  has_many :test_mail_users, :dependent => :destroy
  
  before_create :set_or_reset_token
    
  def self.unsubscribe token
    user = User.find_by_token token
    if user
      user.update_attributes subscribed: false
    end
  end
  
  private
  
  def set_or_reset_token
   write_attribute :token, generate_token(self.mail)
  end
  
  def generate_token(param)
    # http://www.ruby-doc.org/core/classes/Time.html#M000392
    # http://stackoverflow.com/a/6591427/464685
    Digest::MD5.hexdigest(param + rand.to_s + Time.now.strftime('%9N').to_s).encode('UTF-8')
  end
end
