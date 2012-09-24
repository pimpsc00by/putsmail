require "spec_helper"

describe Api::TestMailsController do
  
  let(:test_mail) { double("Test mail", token: "0") }

  before do
    test_mail.stub(:as_json).and_return({})
  end

  describe "#create" do
    it "creates test_mail" do
      TestMail.should_receive(:create).and_return(test_mail)
      post :create
    end
  end

  describe "#show" do
    it "should show by token" do
      TestMail.should_receive(:find_by_token).with("0").and_return(test_mail)
      get "show", id: "0", :format => :json
    end
  end

  describe "#update" do

    let(:mailer) { double("Mailer") }

    before do
      @request.cookies[:last_test_mail_id] = "0"
    end

    it "sends email" do
      mailer.should_receive(:deliver)
      TestMailMailer.should_receive(:test_mail).once.and_return(mailer)
      TestMail.stub(:find_by_token).with("0").and_return(test_mail)
      test_mail_params = {subject: "Test mail", body: "Hi"}
      test_mail.stub(:update_attributes).with(hash_including(test_mail_params)).and_return(true)
      test_mail.stub(active_users: [double("User")])
      test_mail.stub(:increment!)
      put "update", id: "0", test_mail: test_mail_params, :format => :json
    end

    it "should increment sent count" do
      mailer.stub(:deliver)
      TestMailMailer.stub(:test_mail).once.and_return(mailer)
      TestMail.stub(:find_by_token).with("0").and_return(test_mail)
      test_mail_params = {subject: "Test mail", body: "Hi"}
      test_mail.stub(:update_attributes).with(hash_including(test_mail_params)).and_return(true)
      test_mail.stub(active_users: [double("User")])
      test_mail.should_receive(:increment!)
      put "update", id: "0", test_mail: test_mail_params, :format => :json
    end
  end
end
