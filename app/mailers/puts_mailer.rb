class PutsMailer < ActionMailer::Base
  default :from => 'test@putsmail.com'

  def puts_mail(to, subject, body)
    @body = body
    mail(:to => to, :subject => subject)
  end
  
end