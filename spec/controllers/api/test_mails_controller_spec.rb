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
    it "should show by id" do
      test_mail = Factory :test_mail
      get 'show', id: test_mail.id, :format => :json
      response.body.should == test_mail.to_json
    end
  end
  
  describe "PUT 'update'" do
    it "returns http success" do
      # TODO Needs to be refactored
      test_mail = Factory :test_mail, subject: "subject1", body: "body1"
      put 'update', id: test_mail.id, test_mail: {subject: "subject2", body: "body2"}, :format => :json
      response.should be_success
    end
  end

end
