class PutsMailer < ActionMailer::Base
  default :from => 'test@putsmail.com'

  def puts_mail(user, subject, mailBody)
    @mailBody = mailBody
    @user = user
    mail(:to => user.mail, :subject => subject)
  end
  
end