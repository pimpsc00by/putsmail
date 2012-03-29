require 'spec_helper'

describe Api::TestMailUsersController do
  
  before(:each) do
    @test_mail = Factory :test_mail
    @request.cookies[:last_test_mail_id] = @test_mail.token
  end

  describe "POST 'create'" do
    it "returns http success" do
      assert_difference "TestMailUser.count" => +1, "User.count" => +1 do
        post 'create', mail: "pablo@pablocantero.com", :format => :json
      end
      @test_mail.test_mail_users.reload
      response.body.should == @test_mail.test_mail_users.last.to_json
    end
  end
  
  describe "GET 'show'" do
    it "should show by id" do
      test_mail_user = @test_mail.test_mail_users.create user: Factory(:user)
      get 'show', id: test_mail_user.id, :format => :json
      response.body.should == test_mail_user.to_json
    end
  end
  
  describe "GET 'index'" do
    it "should get all by test_mail.id" do
      @test_mail.test_mail_users.create user: Factory(:user)
      @test_mail.test_mail_users.create user: Factory(:user)
      get 'index', :format => :json
      @test_mail.test_mail_users.reload
      response.body.should == @test_mail.test_mail_users.to_json
    end
  end
  
  describe "DESTROY 'destroy'" do
    it "should destroy a record" do
      test_mail_user = @test_mail.test_mail_users.create user: Factory(:user)
      assert_difference "TestMailUser.count" => -1 do
        delete 'destroy', id: test_mail_user.id, :format => :json
      end
    end
  end
  
  describe "PUT 'update'" do
    it "should activate a test_mail_user" do
      test_mail_user = @test_mail.test_mail_users.create user: Factory(:user), active: false
      put "update", id: test_mail_user.id, test_mail_user: {active: true}
      test_mail_user.reload
      test_mail_user.active.should be_true
    end
  end
end
