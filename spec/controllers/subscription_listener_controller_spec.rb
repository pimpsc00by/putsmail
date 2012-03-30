require 'spec_helper'

describe SubscriptionListenerController do

  describe "POST 'subscribe'" do
    it "returns http success" do
      user = Factory :user, subscribed: false
      post 'subscribe', x_from_header: [user.mail]
      user.reload
      user.subscribed.should be_true
      response.should be_success
    end
    
    it "should not fail with invalid mail" do
      post 'subscribe', x_from_header: ["blah"]
      response.should be_success
    end
  end
  
  describe "POST 'unsubscribe'" do
    it "returns http success" do
      user = Factory :user, subscribed: true
      post 'unsubscribe', x_from_header: [user.mail]
      user.reload
      user.subscribed.should be_false
      response.should be_success
    end
    
    it "should not fail with invalid mail" do
      post 'unsubscribe', x_from_header: ["blah"]
      response.should be_success
    end
  end
end
