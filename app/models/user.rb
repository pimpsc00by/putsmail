require 'email_format_validator'
class User < ActiveRecord::Base
  
  validates_uniqueness_of :mail, :allow_nil => false
  
  validates :mail, :presence => true, :email_format => true
  
  before_create :generate_token
  
  private
  
  def generate_token
    # write_attribute :token, self.mail.crypt((rand * 1000).to_s)
    write_attribute :token, Digest::MD5.hexdigest(self.mail)
  end
  
end
