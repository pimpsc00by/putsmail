class PutsMailer < ActionMailer::Base
  default :from => 'test@putsmail.com'

  def puts_mail(to, subject, mailBody)
    @mailBody = mailBody
    mail(:to => to, :subject => subject)
  end
  
end