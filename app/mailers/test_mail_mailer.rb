class TestMailMailer < ActionMailer::Base
  default from: "test@putsmail.com"
  
  def test_mail mail
    @mail_body = mail.body
    to = mail.users.first.mail
    cc = mail.users.slice(1, mail.users.size)
    cc.map! { | u | u.mail}
    mail(to: to, cc: cc, subject: mail.subject, reply_to: to)
  end
end
