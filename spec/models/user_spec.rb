require "spec_helper"

describe User do

  describe "#create_user_token" do
    let(:user_email) { "apu@kwik-e-mart.com" }
    let(:user_token) { "awesome token" }
    let(:hexdigest)  { double("Hexdigest", encode: user_token) }

    it "generates user token" do
      Digest::MD5.stub(:hexdigest)
      .with(include(user_email))
      .and_return(hexdigest)

      apu = User.create mail: user_email

      expect(apu.token).to eq user_token
    end
  end

  describe "#subscribe!" do
    subject(:user) { stub_model(User) }

    it "subscribes an user" do
      user.should_receive(:update_attributes)
      .with(subscribed: true)

      user.subscribe!
    end
  end

  describe "#unsubscribe!" do
    subject(:user) { stub_model(User) }

    it "subscribes an user" do
      user.should_receive(:update_attributes)
      .with(subscribed: false)

      user.unsubscribe!
    end
  end
end
