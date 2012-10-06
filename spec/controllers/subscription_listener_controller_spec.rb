require "spec_helper"

describe SubscriptionListenerController do

  let(:user_mail) { "pablo@pablocantero.com" }
  let(:user)      { stub_model User, mail: user_mail, :subscribed= => true }

  before do
    User.stub(:find_by_mail).with(user_mail).and_return(user)
  end

  describe "#subscribe" do
    it "subscribes an user" do
      user.should_receive :subscribe!

      post "subscribe", x_from_header: [user_mail]
    end

    it "ignores invalid user" do
      User.stub find_by_mail: nil

      post "subscribe", x_from_header: [""]
      
      expect(response).to be_success
    end
  end

  describe "#unsubscribe" do
    it "unsubscribes an user" do
      user.should_receive(:unsubscribe!)

      post "unsubscribe", x_from_header: [user_mail]
    end

    it "ignores invalid user" do
      User.stub find_by_mail: nil

      post "unsubscribe", x_from_header: [""]

      expect(response).to be_success
    end
  end
end
