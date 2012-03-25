require 'spec_helper'
describe TestMail do
  
  describe "Mailer" do
    it "should send email after_update" do
      mailer = mock
      mailer.should_receive(:deliver)
      TestMailMailer.should_receive(:test_mail).and_return(mailer)
      test_mail = Factory :test_mail
      test_mail.test_mail_users.build user: Factory(:user)
      test_mail.save
    end
  end
end
