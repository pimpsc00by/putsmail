require "spec_helper"

describe User do

  describe "Tokens" do
    it "should create a token" do
      # http://en.wikipedia.org/wiki/Apu_Nahasapeemapetilon
      # http://en.wikipedia.org/wiki/Kwik-E-Mart
      apu2 = User.new(:mail => "apu2@kwik-e-mart.com")
      Digest::MD5.should_receive(:hexdigest).with(include(apu2.mail)).and_return(stub(encode:  "awesome token"))
      apu2.save
      expect(apu2.token).to eq "awesome token"
    end
  end

  describe "Validations" do 
    it "should validate mail" do
      # http://en.wikipedia.org/wiki/Ned_Flanders
      # http://en.wikipedia.org/wiki/List_of_fictional_locations_in_The_Simpsons#The_Leftorium
      # invalid 1
      ned = User.new :mail => "ned@the-leftorium"
      expect(ned).to_not be_valid
      # invalid 2
      ned.mail = "nedthe-leftorium.com"
      expect(ned).to_not be_valid
      # invalid 3
      ned.mail = "ned the-leftorium.com"
      expect(ned).to_not be_valid
      # valid 1
      ned.mail = "ned@the-leftorium.com"
      expect(ned).to be_valid
    end
  end

  context "Subscriptions" do
    it "should subscribe on create" do
      user = User.create mail: "apu@kwikemart.com"
      expect(user.subscribed).to be_true
    end

    it "should unsubscribe" do
      user = FactoryGirl.create :user, subscribed: true
      User.unsubscribe user.token
      user.reload
      expect(user.subscribed).to be_false
    end
  end

end
