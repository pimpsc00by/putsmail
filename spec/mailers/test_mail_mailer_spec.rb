require "spec_helper"

describe TestMailMailer do
  describe "test_mail" do
    let(:mail) { 
      @mail = Factory :test_mail, subject: "Test mail", body: "Hi"
      @mail.test_mail_users.build user: Factory(:user, mail: "pablo@pablocantero.com")
      @mail.save
      TestMailMailer.test_mail @mail
    }

    it "renders the headers" do
      mail.subject.should eq @mail.subject
      mail.to.should eq [@mail.users.first.mail]
      mail.from.should eq ["test@putsmail.com"]
    end

    it "renders the body" do
      mail.body.encoded.should match(@mail.body)
    end
    
    it "renders the token" do
      mail.body.encoded.should match(@mail.token)
    end
  end
end
