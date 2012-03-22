require 'spec_helper'

describe TestMail do
  describe "Validation" do
    it "should validate minimum 1 recipient" do
      test_mail = TestMail.new subject: "Test", body: "Hello World!"
      test_mail.valid?.should be_false
      test_mail.recipients = ["pablo@pablocantero.com"]
      test_mail.valid?.should be_true
    end
    
    it "should ignore empty recipient" do
      test_mail = TestMail.new subject: "Test", body: "Hello World!"
      test_mail.valid?.should be_false
      test_mail.recipients = [""]
      test_mail.valid?.should be_false
      test_mail.recipients = ["", "", ""]
      test_mail.valid?.should be_false
      test_mail.recipients = ["pablo@pablocantero.com"]
      test_mail.valid?.should be_true
    end
    
    it "should validate emails" do
      test_mail = TestMail.new subject: "Test", body: "Hello World!"
      test_mail.valid?.should be_false
      test_mail.recipients = ["pablo"]
      test_mail.valid?.should be_false
      test_mail.recipients = ["pablo@pablocantero"]
      test_mail.valid?.should be_false
      test_mail.recipients = ["pablo@pablocantero.com"]
      test_mail.valid?.should be_true
    end

    it "should validate subscribed users" do
      user = Factory :user # , subscribed: false
      user.subscribed = false
      user.save 
      test_mail = TestMail.new subject: "Test", body: "Hello World!", recipients: [user.mail]
      test_mail.valid?.should be_false
      user.subscribed = true
      user.save
      test_mail.test_mail_users.reload
      test_mail.valid?.should be_true
    end

    it "should require subject and body" do
      user = Factory :user
      test_mail = TestMail.new recipients: [user.mail]
      test_mail.valid?.should be_false
      test_mail.subject = "Test"
      test_mail.valid?.should be_false
      test_mail.body = "Hello World!"
      test_mail.valid?.should be_true
      test_mail.subject = nil
      test_mail.valid?.should be_false
    end
  end

  describe "Recipients" do
    it "should convert recipients into users" do
      recipient1 = "pablo1@pablocantero.com"
      recipient2 = "pablo2@pablocantero.com"
      test_mail = TestMail.new subject: "Test", body: "Hello World!", recipients: [recipient1, recipient2]
      assert_difference "TestMailUser.count" => +2, "User.count" => +2 do
        test_mail.save
      end
      users = test_mail.test_mail_users.map do | test_mail_user | 
        test_mail_user.user
      end
      users.should include(User.find_by_mail(recipient1))
      users.should include(User.find_by_mail(recipient2))
    end

    it "should not duplicate" do
      recipient = "pablo@pablocantero.com"
      test_mail = TestMail.new subject: "Test", body: "Hello World!", recipients: [recipient, recipient]
      assert_difference "TestMailUser.count" => +1, "User.count" => +1 do
        test_mail.save
      end
    end
  end
end
