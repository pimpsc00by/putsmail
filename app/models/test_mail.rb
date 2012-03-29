class TestMail < ActiveRecord::Base
  has_many :test_mail_users, dependent: :destroy
  
  has_many :active_test_mail_users, conditions: ["active = ?", true], class_name: "TestMailUser"
  
  has_many :users, :through => :test_mail_users
  
  has_many :active_users, :through => :active_test_mail_users, source: :user
  
  before_create :assign_unique_token
  
  validates_length_of :test_mail_users, maximum: 10
  
  def self.total_sent_count
    # 32977 isn't a magic number, it is the total sent in the Puts Mail V1
    # Puts Mail V1 28/03/2012 - http://f.cl.ly/items/3A1s3H0E2w2i3e210Y1f/Screen%20Shot%202012-03-28%20at%2011.05.21%20AM.png
    # putsmail.heroku.com
    total_sent_puts_mail_v1 = 32977
    TestMail.sum("sent_count") + total_sent_puts_mail_v1
  end
  
  private
  def assign_unique_token
    # http://stackoverflow.com/questions/2125384/assigning-each-user-a-unique-100-character-hash-in-ruby-on-rails
    self.token = SecureRandom.hex(15).to_s until !self.token.nil? and unique_token?
  end

  def unique_token?
    self.class.count(:conditions => {:token => token}) == 0
  end
end
