require 'spec_helper'

describe Api::TestMailsController do

  describe "POST 'create'" do
    it "returns http success"
  end

  describe "GET 'show'" do
    it "should show by token" do
      test_mail = FactoryGirl.create :test_mail
      get 'show', id: test_mail.token, :format => :json
      response.body.should == test_mail.to_json
    end
  end

  describe "PUT 'update'" do

    before(:each) do
      @test_mail = FactoryGirl.create :test_mail
      @request.cookies[:last_test_mail_id] = @test_mail.token
    end

    it "should send email" do
      mailer = mock
      mailer.should_receive(:deliver)
      TestMailMailer.should_receive(:test_mail).once.and_return(mailer)
      @test_mail.test_mail_users.create user: FactoryGirl.create(:user), active: true
      put 'update', id: @test_mail.token, test_mail: {subject: "Test mail", body: "Hi"}, :format => :json
      response.should be_success
    end

    it "should increment sent count" do
      mailer = mock
      mailer.should_receive(:deliver).once
      TestMailMailer.should_receive(:test_mail).once.and_return(mailer)
      @test_mail.test_mail_users.create user: FactoryGirl.create(:user), active: true
      expect{
        put 'update', id: @test_mail.id, test_mail: {subject: "Test mail", body: "Hi"}, :format => :json
      }.to change{@test_mail.reload; @test_mail.sent_count.to_i}.by(1)
      response.should be_success
    end
  end
end
