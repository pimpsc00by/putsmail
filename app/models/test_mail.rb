class TestMail < ActiveRecord::Base
  has_many :test_mail_users
  
  # validates :test_mail_users, length: { minimum: 1 }
  validates :body, presence: true
  validates :subject, presence: true
  
  before_validation :convert_recipients_into_test_mail_users
  
  validate :validate_subscribed_users, :validate_recipients_length
  
  # http://www.buildingwebapps.com/articles/79182-validating-email-addresses-with-ruby
  EMAIL_REGEX = /^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/
  
  def subject
    @subject
  end
  
  def subject=(subject)
    @subject=subject
  end
  
  def body
    @body
  end
  
  def body=(body)
    @body=body
  end
  
  def recipients
    @recipients
  end
  
  def recipients=(recipients)
    @recipients = recipients
  end
  
  private
  def validate_subscribed_users
    self.test_mail_users.each_with_index do | test, index |      
      unless test.user.subscribed?
        self.errors.add "test_mail_users#{index}", "is unsubscribed. Send an e-mail to subscribe@putsmail.com, to subscribe it again."
      end
    end
  end
  
  def validate_recipients_length
    valid_recipients = []
    self.recipients.to_a.each_with_index do | recipient, index |
      if !recipient.blank? and EMAIL_REGEX.match(recipient).nil?
        self.errors.add("test_mail_users#{index}", "does not appear to be valid")
      elsif !recipient.blank?
        valid_recipients.push recipient
      end
    end
    self.recipients = valid_recipients
    self.errors.add("test_mail_users0", "can't be blank") if self.recipients.to_a.empty?
  end
  
  def convert_recipients_into_test_mail_users
    recipients.to_a.each do | recipient |  
      user = User.find_or_create_by_mail(recipient)
      if !user.new_record? and !self.test_mail_users.index{| test_mail_user | test_mail_user.user_id == user.id }
        self.test_mail_users.build user: user
      end
    end
  end
end
