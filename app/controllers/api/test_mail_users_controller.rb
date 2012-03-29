class Api::TestMailUsersController < ApplicationController
  respond_to :json

  def create
    test_mail_user = TestMailUser.create params[:test_mail_user]
    respond_with test_mail_user, location: api_test_mail_user_url(test_mail_user)
  end
  
  def show    
    test_mail_user = TestMailUser.find params[:id]
    respond_with test_mail_user
  end
  
  def index
    test_mail = TestMail.find params[:test_mail_id]
    respond_with test_mail.test_mail_users
  end
end