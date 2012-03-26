class TestMail < ActiveRecord::Base
  has_many :test_mail_users, :dependent => :destroy
  
  has_many :users, :through => :test_mail_users
  
  before_create :assign_unique_token
    
  def to_json(options={})
    super(:include => [:users])
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
