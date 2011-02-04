class UsersController < ApplicationController
  
  def create
    user = User.find_or_create_by_mail(params[:mail])
    if !user.new_record?
      UserMailer.registration_confirmation(user).deliver
    end
    json_data = {
      :errors => user.errors
    }
    render :text => json_data.to_json
  end

end
