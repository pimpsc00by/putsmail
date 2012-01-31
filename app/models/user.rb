require 'email_format_validator'
class User < ActiveRecord::Base
  
  validates_uniqueness_of :mail, :allow_nil => false
  validates_uniqueness_of :token, :allow_nil => false
  
  validates :mail, :presence => true, :email_format => true
  
  before_create :set_or_reset_token
  
  def unsubscribe token
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
    # Digest::MD5.hexdigest(param + rand.to_s + Time.now.strftime('%9N').to_s)
    # 100000 ~ 999999
    min = 100000
    max = 999999
    (min + rand(max)).to_i
  end
  
end
