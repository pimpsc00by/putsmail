class UserMailer < ActionMailer::Base
  default :from => 'test@putsmail.com'
  
  def registration_confirmation(user)  
    # @user = user
    # mail(:to => user.mail, :subject => "Puts Mail - Token")  
  end
  
end
