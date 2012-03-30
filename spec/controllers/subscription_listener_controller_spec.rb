require 'spec_helper'

describe SubscriptionListenerController do

  describe "GET 'update'" do
    it "returns http success" do
      get 'create'
      response.should be_success
    end
  end

end
