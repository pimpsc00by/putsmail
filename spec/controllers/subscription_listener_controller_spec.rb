require "spec_helper"

describe SubscriptionListenerController do

  let(:user_mail) { "pablo@pablocantero.com" }
  let(:user) { double "User", mail: user_mail, :subscribed= => true, save: true }

  before do
    User.stub(:find_by_mail).with(user_mail).and_return(user)
  end

  describe "#subscribe" do
    it "subscribes" do
      user.should_receive(:update_attributes).with(subscribed: true)
      post "subscribe", x_from_header: [user_mail]
    end

    it "ignores invalid user" do
      User.stub(:find_by_mail).with("").and_return(nil)
      post "subscribe", x_from_header: [""]
      response.should be_success
    end
  end

  describe "#unsubscribe" do
    it "subscribes" do
      user.should_receive(:update_attributes).with(subscribed: false)
      post "unsubscribe", x_from_header: [user_mail]
    end

    it "ignores invalid user" do
      User.stub(:find_by_mail).with("").and_return(nil)
      post "unsubscribe", x_from_header: [""]
      response.should be_success
    end
  end
end
