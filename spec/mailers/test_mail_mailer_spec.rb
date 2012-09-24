require "spec_helper"

describe TestMailMailer do

  describe "#test_mail" do
    let(:test_mail) { FactoryGirl.create :test_mail, subject: "Test mail", body: "Hi" } 
    let!(:user) { FactoryGirl.create(:user, mail: "pablo@pablocantero.com") }
    let!(:test_mail_user) { test_mail.test_mail_users.create user: user }
    subject(:mailer) { TestMailMailer.test_mail test_mail }

    its(:subject) { should eq test_mail.subject }
    its(:to) { should eq [test_mail.users.first.mail] }
    its(:from) { should eq ["test@putsmail.com"] }

    it "renders the body" do
      mailer.body.encoded.should match(test_mail.body)
    end

    it "renders the token" do
      mailer.body.encoded.should match(test_mail.token)
    end

    context "multiple recipients" do
      before do
        test_mail.test_mail_users.create user: FactoryGirl.create(:user)
        test_mail.test_mail_users.create user: FactoryGirl.create(:user)
        test_mail.test_mail_users.create user: FactoryGirl.create(:user)
      end

      it "sends to all recipients" do
        expect(mailer.to).to eq test_mail.active_users.collect &:mail
      end
    end  
  end
end
