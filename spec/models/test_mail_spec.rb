# encoding: utf-8

require "spec_helper"

describe TestMail do
  describe "#assign_unique_token" do
    subject(:test_mail) { FactoryGirl.create :test_mail }

    its(:token) { should be_present }
  end

  describe "#total_sent_count" do
    it "calculates the total sent"  do
      total_sent_puts_mail_v1 = 32977
      sent_count              = 1000
      TestMail.stub(:sum).with("sent_count").and_return(sent_count)
      expect(TestMail.total_sent_count).to eq (sent_count + total_sent_puts_mail_v1)
    end
  end

  describe "#active_users" do
    subject(:test_mail) { FactoryGirl.create :test_mail }
    it "filters by active status" do
      active      = test_mail.test_mail_users.create user: FactoryGirl.create(:user), active: true
      nonactive   = test_mail.test_mail_users.create user: FactoryGirl.create(:user), active: false
      expect(test_mail.active_users).to eq [active.user]
    end
  end

  describe "#public_mals" do
    it "ignores empty mail body" do
      test_mail = FactoryGirl.create :test_mail, body: "", in_gallery: true
      expect { TestMail.public_mails.find(test_mail.id) }.to raise_error(ActiveRecord::RecordNotFound) 
    end

    it "ignores nil mail body" do
      test_mail = FactoryGirl.create :test_mail, body: nil, in_gallery: true
      expect { TestMail.public_mails.find(test_mail.id) }.to raise_error(ActiveRecord::RecordNotFound) 
    end

    it "ignores default mail body" do
      test_mail = FactoryGirl.create :test_mail, body: "<li>Do not use JavaScript.</li>", in_gallery: true
      expect { TestMail.public_mails.find(test_mail.id) }.to raise_error(ActiveRecord::RecordNotFound) 
    end

    it "ignores not in gallery" do
      test_mail = FactoryGirl.create :test_mail, body: "Valid body", in_gallery: false
      expect { TestMail.public_mails.find(test_mail.id) }.to raise_error(ActiveRecord::RecordNotFound) 
    end

    it "filters in gallery" do
      test_mail = FactoryGirl.create :test_mail, body: "Valid body", in_gallery: true
      expect { TestMail.public_mails.find(test_mail.id) }.to_not raise_error(ActiveRecord::RecordNotFound) 
    end
  end

  describe "#update" do
    let(:mailer)           { double "Mailer" }
    let(:user)             { double "User" }
    let(:active_users)     { [user] }
    subject(:test_mail)    { FactoryGirl.create :test_mail }

    before do
      test_mail.stub active_users: active_users
    end

    it "does not send an email" do
      TestMailMailer.should_not_receive(:test_mail).and_return mailer
      test_mail.update_attributes dispatch: false
    end

    it "sends an email" do
      mailer.should_receive :deliver
      TestMailMailer.should_receive(:test_mail).and_return mailer
      test_mail.stub :increment!
      test_mail.update_attributes dispatch: true
    end

    it "updates dispatch to false" do
      mailer.should_receive :deliver
      TestMailMailer.stub(:test_mail).and_return mailer
      test_mail.stub :increment!
      test_mail.update_attributes dispatch: true
      expect(test_mail.dispatch).to be_false
    end

    it "does not increments the sent counter" do
      test_mail.should_not_receive :increment!
      test_mail.update_attributes dispatch: false
    end

    it "increments the sent counter" do
      mailer.stub :deliver
      TestMailMailer.stub(:test_mail).once.and_return mailer
      test_mail.should_receive :increment!
      test_mail.update_attributes dispatch: true
    end
  end
end
