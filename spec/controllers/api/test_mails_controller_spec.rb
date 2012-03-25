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
    it "returns http success" do
      test_mail = Factory :test_mail
      get 'show', id: test_mail.id, :format => :json
      response.body.should == test_mail.to_json
    end
  end
  
  describe "PUT 'update'" do
    it "returns http success" do
      # TODO Need a refactory
      test_mail = Factory :test_mail, subject: "subject1", body: "body1"
      put 'update', id: test_mail.id, test_mail: {subject: "subject2", body: "body2"}, :format => :json
      response.should be_success
    end
  end

end
