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
  
  describe "Total sent" do
    it "should sum the sent total + Puts Mail V1 total" do
      a = Factory :test_mail, sent_count: 10
      b = Factory :test_mail, sent_count: 10
      total_sent_puts_mail_v1 = 32977
      TestMail.total_sent_count.should == a.sent_count + b.sent_count + total_sent_puts_mail_v1
    end
  end
end
