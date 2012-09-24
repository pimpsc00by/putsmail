class SubscriptionListenerController < ApplicationController
  skip_before_filter :verify_authenticity_token

  before_filter :x_from_header_to_user

  def subscribe
    @user.update_attributes(subscribed: true) if @user
    render :text => "success", :status => 200
  end

  def unsubscribe
    @user.update_attributes(subscribed: false) if @user
    render :text => "success", :status => 200
  end

  private
  def x_from_header_to_user
    from = params[:x_from_header].to_s.gsub /\[|\]|\"|\s/, ""
    @user = User.find_by_mail(from)
  end
end

