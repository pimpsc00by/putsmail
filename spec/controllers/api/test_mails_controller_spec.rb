require "spec_helper"

describe Api::TestMailsController do

  let(:test_mail) { double("Test mail", token: "0") }
  let(:test_mail_params) do
    { "subject" =>  "Test mail", "body" => "Hi", "dispatch" => false }
  end

  before do
    test_mail.stub(:as_json).and_return({})
    @request.cookies[:last_test_mail_id] = "0"
    TestMail.stub(:find_by_token!).with("0").and_return test_mail
  end

  describe "#create" do
    it "creates test_mail" do
      TestMail.should_receive(:create)
      .with(test_mail_params)
      .and_return(test_mail)
      post :create, test_mail: test_mail_params
    end
  end

  describe "#show" do
    it "loads by token" do
      TestMail.should_receive(:find_by_token!).with("0").and_return(test_mail)
      get "show", id: "0", :format => :json
    end
  end

  describe "#update" do
    it "sends an email" do
      test_mail.stub(:update_attributes).with(test_mail_params).and_return(true)
      put "update", id: "0", test_mail: test_mail_params, dispatch: false, :format => :json
    end
  end
end

