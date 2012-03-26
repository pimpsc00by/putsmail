require 'spec_helper'
describe TestMail do
  describe "Unique token" do
    it "should create an unique not nil token for each TestMail" do
      a = Factory :test_mail
      b = Factory :test_mail
      a.token.should_not be_nil
      b.token.should_not be_nil
      a.token.should_not eq b.token
    end
  end
end
