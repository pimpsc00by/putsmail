require "spec_helper"

describe TestMailMailer do
  describe "test_mail" do
    let(:mail) { TestMailMailer.test_mail }

    it "renders the headers" do
      mail.subject.should eq("Test mail")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
