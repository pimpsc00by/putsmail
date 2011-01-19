require "spec_helper"

describe PutsMailer do
  describe "send" do
    let(:mail) { PutsMailer.puts_mail('pablo@putsmail.com', 'Send', 'Hi') }

    it "renders the headers" do
      mail.subject.should eq("Send")
      mail.to.should eq(["pablo@putsmail.com"])
      mail.from.should eq(["test@putsmail.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
