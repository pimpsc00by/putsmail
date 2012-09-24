require "spec_helper"
describe TestMail do
  describe "Tokens" do
    subject(:test_mail) { FactoryGirl.create :test_mail }
    it "should find by token" do
      expect(TestMail.find_by_token(test_mail.token)).to eq test_mail
    end
  end

  describe "Total sent" do
    it "should sum"  do
      total_sent_puts_mail_v1 = 32977
      sent_count = 1000
      TestMail.stub(:sum).with("sent_count").and_return(sent_count)
      expect(TestMail.total_sent_count).to eq (sent_count + total_sent_puts_mail_v1)
    end
  end

  describe "Active recipients" do
    subject(:test_mail) { FactoryGirl.create :test_mail }
    it "should return active recipients" do
      active      = test_mail.test_mail_users.create user: FactoryGirl.create(:user), active: true
      nonactive   = test_mail.test_mail_users.create user: FactoryGirl.create(:user), active: false
      test_mail.active_users.should eq [active.user]
    end
  end

  describe "Public emails" do
    it "should ignore empty mail body" do
      test_mail = FactoryGirl.create :test_mail, body: "", in_gallery: true
      expect { TestMail.public_mails.find(test_mail.id) }.to raise_error(ActiveRecord::RecordNotFound) 
    end

    it "should ignore nil mail body" do
      test_mail = FactoryGirl.create :test_mail, body: nil, in_gallery: true
      expect { TestMail.public_mails.find(test_mail.id) }.to raise_error(ActiveRecord::RecordNotFound) 
    end

    it "should ignore default mail body" do
      test_mail = FactoryGirl.create :test_mail, body: "<li>Do not use JavaScript.</li>", in_gallery: true
      expect { TestMail.public_mails.find(test_mail.id) }.to raise_error(ActiveRecord::RecordNotFound) 
    end

    it "should not return in gallery" do
      test_mail = FactoryGirl.create :test_mail, body: "Valid body", in_gallery: false
      expect { TestMail.public_mails.find(test_mail.id) }.to raise_error(ActiveRecord::RecordNotFound) 
    end

    it "should return in gallery" do
      test_mail = FactoryGirl.create :test_mail, body: "Valid body", in_gallery: true
      expect { TestMail.public_mails.find(test_mail.id) }.to_not raise_error(ActiveRecord::RecordNotFound) 
    end
  end
end
