class SubscriptionListenerController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def subscribe
    Rails.logger.info "subscribe/message.x_from_header: #{params[:x_from_header]}" #print the decoded body to the logs
    # Do some other stuff with the mail message
    render :text => 'success', :status => 200 # a status of 404 would reject the mail
  end
  
  def unsubscribe
    Rails.logger.info "unsubscribe/message.x_from_header: #{params[:x_from_header]}" #print the decoded body to the logs
    # Do some other stuff with the mail message
    render :text => 'success', :status => 200 # a status of 404 would reject the mail
  end
end

