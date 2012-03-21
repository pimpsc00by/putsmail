class TestMail < ActiveRecord::Base
  has_many :test_mail_users
  
  # validates :test_mail_users, length: { minimum: 1 }
  validates :body, presence: true
  validates :subject, presence: true
  
  before_validation :convert_recipients_into_test_mail_users
  
  validate :validate_subscribed_users, :validate_recipients_length
  
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
    self.test_mail_users.each do | test |      
      unless test.user.subscribed?
        self.errors.add test.user.mail, "#{test.user.mail} unsubscribed the list."
      end
    end
  end
  
  def validate_recipients_length
    self.errors.add "recipients", "can't be empty"
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
