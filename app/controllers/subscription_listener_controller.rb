class SubscriptionListenerController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def subscribe
    from = params[:x_from_header].to_a.first
    if user = User.find_by_mail(from)
      user.subscribed = true
      user.save
    end
    render :text => 'success', :status => 200
  end
  
  def unsubscribe
    from = params[:x_from_header].to_a.first
    if user = User.find_by_mail(from)
      user.subscribed = false
      user.save
    end
    render :text => 'success', :status => 200 # a status of 404 would reject the mail
  end
end

