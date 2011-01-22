class UserMailer < ActionMailer::Base
  default :from => 'test@putsmail.com'
  
  def registration_confirmation(user)  
    @user = user
    # mail(:to => user.mail, :subject => "Puts Mail - Token")  
    mail(:to => user.mail, :subject => "OMG! Your token was replaced by a friendly token")  
  end
  
end
