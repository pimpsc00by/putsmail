require 'spec_helper'

describe UsersController do

  describe "GET 'create'" do
    
    it "should be successful" do
      get 'create'
      response.should be_success
    end
    
    it "should be successful with errors" do
      mail = 'ned@the-leftorium.com'
      user = mock(User)
      user.stub!(:new_record?).and_return(false)
      user.stub!(:token_reset?).and_return(false)
      errors = {:mail => "can't be blank"}
      user.stub!(:errors).and_return(errors)
      User.stub!(:reset_or_create_by_mail).with(mail).and_return(user)
      mailer = mock(ActionMailer::Base)
      mailer.stub!(:deliver)
      UserMailer.stub!(:registration_confirmation).and_return(mailer)
      post 'create', :mail => mail
      response.body.should eql("{\"token_reset\":false,\"errors\":{\"mail\":\"can't be blank\"}}")
    end
    
    it "should be successful" do
      mail = 'ned@the-leftorium.com'
      user = mock(User)
      user.stub!(:new_record?).and_return(false)
      user.stub!(:token_reset?).and_return(false)
      errors = {}
      user.stub!(:errors).and_return(errors)
      User.stub!(:reset_or_create_by_mail).with(mail).and_return(user)
      mailer = mock(ActionMailer::Base)
      mailer.stub!(:deliver)
      UserMailer.stub!(:registration_confirmation).and_return(mailer)
      post 'create', :mail => mail
      response.body.should eql("{\"token_reset\":false,\"errors\":{}}")
    end
    
  end

end
