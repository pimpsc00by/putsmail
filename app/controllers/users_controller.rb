class UsersController < ApplicationController
  
  def create
    user = User.find_or_create_by_mail(:mail => params[:mail])
    if !user.new_record?
      UserMailer.registration_confirmation(user).deliver
    end
    render :text => user.errors.to_json
  end

end
