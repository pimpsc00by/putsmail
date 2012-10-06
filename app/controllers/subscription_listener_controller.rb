class SubscriptionListenerController < ApplicationController
  skip_before_filter :verify_authenticity_token

  before_filter :load_user_from_x_from_header

  def subscribe
    @user.subscribe! if @user
    render :text => "success", :status => 200
  end

  def unsubscribe
    @user.unsubscribe! if @user
    render :text => "success", :status => 200
  end

  private
  def load_user_from_x_from_header
    from = params[:x_from_header].to_s.gsub /\[|\]|\"|\s/, ""
    @user = User.find_by_mail(from)
  end
end

