require "spec_helper"

describe Api::TestMailUsersController do

  let(:test_mail) { FactoryGirl.create :test_mail } 
  let(:test_mail_users) { double("Test mail users") }
  let(:test_mail_user) { double(TestMailUser.new, id: 0) }
  let(:user) { double("user", id: 0) }

  before do
    @request.cookies[:last_test_mail_id] = test_mail.token
    test_mail.stub(:test_mail_users).and_return(test_mail_users)
    TestMail.stub(:find_by_token).with(test_mail.token).and_return(test_mail)
    test_mail_user.stub(:as_json).and_return({})
    test_mail_users.stub(:as_json).and_return({})
  end

  describe "#create" do
    it "creates an user" do
      User.should_receive(:find_or_create_by_mail)
      .with("pablo@pablocantero.com")
      .and_return(user)
      test_mail_users.stub(:create).and_return(test_mail_user)
      post "create", mail: "pablo@pablocantero.com", :format => :json
    end

    it "adds to test_mail_users" do
      User.stub(:find_or_create_by_mail)
      .and_return(user)
      test_mail_users.should_receive(:create).with(user_id: user.id).and_return(test_mail_user)
      post "create", mail: "pablo@pablocantero.com", :format => :json
    end

    it "responds with json" do
      User.stub(:find_or_create_by_mail)
      .and_return(user)
      test_mail_users.stub(:create).with(user_id: user.id).and_return(test_mail_user)
      post "create", mail: "pablo@pablocantero.com", :format => :json
      expect(response.body).to eq "{}"
    end
  end

  describe "#show" do
    it "loads test_mail_user" do
      test_mail_users.should_receive(:find).with("0")
      get "show", id: 0, :format => :json
    end
  end

  describe "#index" do
    it "loads all test_mail_user" do
      test_mail_users.should_receive(:all)
      get "index", :format => :json
    end
  end

  describe "#destroy" do
    it "destroys test_mail_user" do
      test_mail_users.should_receive(:destroy).with("0")
      delete "destroy", id: 0, :format => :json
    end
  end

  describe "#update" do
    it "should activate a test_mail_user" do
      test_mail_users.stub(:find).with("0").and_return(test_mail_user)
      test_mail_user.should_receive(:update_attributes).with(hash_including(active: true))
      put "update", id: test_mail_user.id, test_mail_user: {active: true}
    end
  end
end
