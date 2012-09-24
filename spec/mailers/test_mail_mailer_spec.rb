require "spec_helper"

describe TestMailMailer do
  describe "Send email" do
    let(:mail) do
      @mail = FactoryGirl.create :test_mail, subject: "Test mail", body: "Hi"
      @mail.test_mail_users.build user: FactoryGirl.create(:user, mail: "pablo@pablocantero.com")
      @mail.save
      TestMailMailer.test_mail @mail
    end

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

  describe "Recipients" do
    let(:three_mail) do
      @mail = FactoryGirl.create :test_mail, subject: "Test mail", body: "Hi"
      @mail.test_mail_users.build user: FactoryGirl.create(:user)
      @mail.test_mail_users.build user: FactoryGirl.create(:user)
      @mail.test_mail_users.build user: FactoryGirl.create(:user)
      @mail.save
      TestMailMailer.test_mail @mail
    end
    it "should add more recipients" do
      three_mail.to.should eq @mail.active_users.collect &:mail
    end
  end
end
