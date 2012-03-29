class TestMailMailer < ActionMailer::Base
  default from: "test@putsmail.com"
  
  def test_mail mail
    @mail_body = mail.body
    @mail_token = mail.token
    to = mail.active_users.first.mail
    if mail.active_users.size > 1
      cc = mail.active_users.slice(1, mail.active_users.size)
      cc.map! { | u | u.mail}
    end
    mail(to: to, cc: cc, subject: mail.subject, reply_to: to)
  end
end
