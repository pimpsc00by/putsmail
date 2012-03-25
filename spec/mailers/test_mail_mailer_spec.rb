require "spec_helper"

describe TestMailMailer do
  describe "test_mail" do
    let(:mail) { 
      test_mail = Factory :test_mail, subject: "Test mail", body: "Hi"
      test_mail.test_mail_users.build user: Factory(:user, mail: "pablo@pablocantero.com")
      test_mail.save
      TestMailMailer.test_mail test_mail
    }

    it "renders the headers" do
      mail.subject.should eq("Test mail")
      mail.to.should eq(["pablo@pablocantero.com"])
      mail.from.should eq(["test@putsmail.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
