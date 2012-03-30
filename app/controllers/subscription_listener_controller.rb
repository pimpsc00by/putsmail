class SubscriptionListenerController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  before_filter :x_from_header_to_user
  
  def subscribe
    if @user
      @user.subscribed = true
      @user.save
    end
    render :text => 'success', :status => 200
  end
  
  def unsubscribe
    if @user
      @user.subscribed = false
      @user.save
    end
    render :text => 'success', :status => 200 # a status of 404 would reject the mail
  end
  
  private
  def x_from_header_to_user
    from = params[:x_from_header].to_s.gsub /\[|\]|\"|\s/, ""
    @user = User.find_by_mail(from)
  end
end

