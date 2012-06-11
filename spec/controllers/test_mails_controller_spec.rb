require 'spec_helper'

describe TestMailsController do

  describe "GET 'show'" do
    it "returns http success" do
      test_mail = Factory :test_mail
      get 'show', id: test_mail.id
      response.should be_success
    end
  end

end
