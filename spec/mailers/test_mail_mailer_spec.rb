require "spec_helper"

describe TestMailMailer do
  describe "test_mail" do
    let(:mail) { 
      TestMailMailer.test_mail TestMail.create(:body => "Hi", subject: "Test mail", recipients: ["pablo@pablocantero.com"])
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
