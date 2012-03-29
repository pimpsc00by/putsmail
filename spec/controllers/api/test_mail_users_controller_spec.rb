require 'spec_helper'

describe Api::TestMailUsersController do

  describe "POST 'create'" do
    it "returns http success" do
      test_mail = Factory :test_mail
      user = Factory :user
      assert_difference "TestMailUser.count" => +1 do
        post 'create', test_mail_user: {test_mail_id: test_mail.id, user_id: user.id}, :format => :json
      end
      response.body.should == TestMailUser.last.to_json
    end
  end
  
  describe "GET 'show'" do
    it "should show by id" do
      test_mail = Factory :test_mail
      test_mail_user = test_mail.test_mail_users.create user: Factory(:user)
      get 'show', id: test_mail_user.id, :format => :json
      response.body.should == test_mail_user.to_json
    end
  end
  
  describe "GET 'index'" do
    it "should get all by test_mail.id" do
      test_mail = Factory :test_mail
      test_mail.test_mail_users.create user: Factory(:user)
      test_mail.test_mail_users.create user: Factory(:user)
      get 'index', test_mail_id: test_mail.id, :format => :json
      response.body.should == test_mail.test_mail_users.to_json
    end
  end
  
  # describe "PUT 'update'" do
  #   it "should send email after_update" do
  #     mailer = mock
  #     mailer.should_receive(:deliver)
  #     TestMailMailer.should_receive(:test_mail).once.and_return(mailer)
  #     test_mail = Factory :test_mail
  #     test_mail_data = 
  #     put 'update', id: test_mail.id, test_mail: {subject: "Test mail", body: "Hi"}, users: [{mail:"pablo@pablocantero.com"}], :format => :json
  #     response.should be_success
  #   end
  #   
  #   it "should increment sent count" do
  #     mailer = mock
  #     mailer.should_receive(:deliver).once
  #     TestMailMailer.should_receive(:test_mail).once.and_return(mailer)
  #     test_mail = Factory :test_mail
  #     expect{
  #       put 'update', id: test_mail.id, test_mail: {subject: "Test mail", body: "Hi"}, users: [{mail:"pablo@pablocantero.com"}], :format => :json
  #     }.to change{test_mail.reload; test_mail.sent_count.to_i}.by(1)
  #     response.should be_success
  #   end
  # end
end
