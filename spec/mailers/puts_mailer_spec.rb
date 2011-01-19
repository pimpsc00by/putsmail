require "spec_helper"

describe PutsMailer do
  describe "send" do
    let(:mail) { PutsMailer.puts_mail('to@example.org', 'Send', 'Hi') }

    it "renders the headers" do
      mail.subject.should eq("Send")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["megasename@gmail.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
