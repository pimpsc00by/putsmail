require 'spec_helper'

describe Api::TestMailsController do

  describe "POST 'create'" do
    it "returns http success" do
      assert_difference "TestMail.count" => +1 do
        post 'create', :format => :json
      end
      response.body.should == TestMail.last.to_json
    end
  end
  
  describe "GET 'show'" do
    it "should show by token" do
      test_mail = Factory :test_mail
      get 'show', id: test_mail.token, :format => :json
      response.body.should == test_mail.to_json
    end
  end
  
  describe "PUT 'update'" do
    it "should send email after_update" do
      mailer = mock
      mailer.should_receive(:deliver)
      TestMailMailer.should_receive(:test_mail).once.and_return(mailer)
      test_mail = Factory :test_mail
      test_mail_data = 
      put 'update', id: test_mail.id, test_mail: {subject: "Test mail", body: "Hi"}, users: [{mail:"pablo@pablocantero.com"}], :format => :json
      response.should be_success
    end
    
    it "should increment sent count" do
      mailer = mock
      mailer.should_receive(:deliver).once
      TestMailMailer.should_receive(:test_mail).once.and_return(mailer)
      test_mail = Factory :test_mail
      expect{
        put 'update', id: test_mail.id, test_mail: {subject: "Test mail", body: "Hi"}, users: [{mail:"pablo@pablocantero.com"}], :format => :json
      }.to change{test_mail.reload; test_mail.sent_count.to_i}.by(1)
      response.should be_success
    end
  end
end
