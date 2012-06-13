require 'spec_helper'
describe TestMail do
  describe "Unique token" do
    it "should create an unique not nil token for each TestMail" do
      a = Factory :test_mail
      b = Factory :test_mail
      a.token.should_not be_nil
      b.token.should_not be_nil
      a.token.should_not eq b.token
    end
    
    it "should find by token" do
      a = Factory :test_mail
      b = Factory :test_mail
      TestMail.find_by_token(a.token).should eq a
      TestMail.find_by_token(b.token).should eq b
    end
  end
  
  describe "Total sent" do
    it "should sum the sent total + Puts Mail V1 total" do
      a = Factory :test_mail, sent_count: 10
      b = Factory :test_mail, sent_count: 10
      total_sent_puts_mail_v1 = 32977
      TestMail.total_sent_count.should == a.sent_count + b.sent_count + total_sent_puts_mail_v1
    end
  end
  
  describe "Active recipients" do
    it "should return active recipients" do
      test_mail = Factory :test_mail
      active = test_mail.test_mail_users.create user: Factory(:user), active: true
      deactive = test_mail.test_mail_users.create user: Factory(:user), active: false
      test_mail.active_users.should eq [active.user]
    end
  end
  
  describe "Public emails" do
    it "should ignore blank e-mail" do
      test_mail = Factory :test_mail, body: "", in_gallery: true
      expect { TestMail.public_emails.find(test_mail.id) }.to raise_error(ActiveRecord::RecordNotFound) 
    end
    
    it "should ignore nil e-mail" do
      test_mail = Factory :test_mail, body: nil, in_gallery: true
      expect { TestMail.public_emails.find(test_mail.id) }.to raise_error(ActiveRecord::RecordNotFound) 
    end

    it "should ignore default e-mail" do
      test_mail = Factory :test_mail, body: "<li>Do not use JavaScript.</li>", in_gallery: true
      expect { TestMail.public_emails.find(test_mail.id) }.to raise_error(ActiveRecord::RecordNotFound) 
    end
    
    it "should not return valid body without in gallery" do
      test_mail = Factory :test_mail, body: "Valid body", in_gallery: false
      expect { TestMail.public_emails.find(test_mail.id) }.to raise_error(ActiveRecord::RecordNotFound) 
    end

    it "should return a valid e-mail" do
      test_mail = Factory :test_mail, body: "Valid body", in_gallery: true
      expect { TestMail.public_emails.find(test_mail.id) }.to_not raise_error(ActiveRecord::RecordNotFound) 
    end
  end
end
