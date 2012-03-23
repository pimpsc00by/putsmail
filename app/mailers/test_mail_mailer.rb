class TestMailMailer < ActionMailer::Base
  default from: "test@putsmail.com"
  
  def test_mail mail
    @mail_body = mail.body
    to = mail.recipients.first
    cc = mail.recipients.slice(1, mail.recipients.size)
    mail(to: to, cc: cc, subject: mail.subject, reply_to: to)
  end
end
