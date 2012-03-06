require 'email_format_validator'
class User < ActiveRecord::Base  
  validates :mail, :uniqueness => true, :allow_nil => :false, :email_format => true
  
  before_create :set_or_reset_token
  before_create :set_default_subscribed_value
  
  def self.unsubscribe token
    user = User.find_by_token token
    if user
      user.subscribed = false
      user.save
    end
  end
  
  private
  
  def set_or_reset_token
   write_attribute :token, generate_token(self.mail)
  end
  
  def generate_token(param)
    # write_attribute :token, self.mail.crypt((rand * 1000).to_s)
    # write_attribute :token, Digest::MD5.hexdigest(self.mail)
    # http://www.ruby-doc.org/core/classes/Time.html#M000392
    Digest::MD5.hexdigest(param + rand.to_s + Time.now.strftime('%9N').to_s)
  end
  
  def set_default_subscribed_value
    self.subscribed = true
  end
  
end
