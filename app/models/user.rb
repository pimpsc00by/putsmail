require 'email_format_validator'
class User < ActiveRecord::Base
  
  validates_uniqueness_of :mail, :allow_nil => false
  
  validates :mail, :presence => true, :email_format => true
  
  before_create :set_or_reset_token
  
  def self.reset_or_create_by_mail(mail)
    user = User.find_by_mail(mail)
    if user.nil?
      user = User.create(:mail => mail)
    else
      user.set_or_reset_token
      user.save
    end
    user
  end
  
  def token_reset?
    @token_reset == true
  end
    
  def set_or_reset_token
    @token_reset = self.token != nil
    write_attribute :token, generate_token(self.mail)
  end
  
  private
  
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
