require 'spec_helper'
describe TestMail do
  
  describe "Mailer" do
    it "should send email after_update" do
      mailer = mock
      mailer.should_receive(:deliver)
      TestMailMailer.should_receive(:test_mail).once.and_return(mailer)
      test_mail = Factory :test_mail
      test_mail.test_mail_users.build user: Factory(:user)
      test_mail.save
    end
  end
  
  describe "Unique token" do
    it "should create an unique not nil token for each TestMail" do
      a = Factory :test_mail
      b = Factory :test_mail
      a.token.should_not be_nil
      b.token.should_not be_nil
      a.token.should_not be b.token
    end
  end
end
