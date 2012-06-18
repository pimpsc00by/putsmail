class TestMailMailer < ActionMailer::Base
  default from: "test@putsmail.com"
  
  def test_mail mail
    @mail_body = mail.body
    @mail_token = mail.token
    to = mail.active_users.collect &:mail
    mail(to: to, subject: mail.subject, reply_to: to)
  end
end
