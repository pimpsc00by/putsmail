require "email_format_validator"
class PutsMail
  include ActiveAttr::Model

  attribute :to
  attribute :subject
  attribute :body
  attribute :user

  validates :to, :email_format => true
  validates :subject, :presence => true
  validates :body, :presence => true

  validate :find_or_create_user_with_success

  def save 
    return unless valid?
    if PutsMailer.puts_mail(self.user, self.subject, self.body).deliver
      Property.increment_mail_counter
    end
  end

  private

  def find_or_create_user_with_success
    return if self.to.to_s.blank?
    self.user = User.find_or_create_by_mail(self.to)
    unless self.user.subscribed?
      self.errors.add(:user, "'#{self.to}' was unsubscribed the Puts Mail Test List. To subscribe it again, send an e-mail to subscribe@putsmail.com")
    end
  end
end