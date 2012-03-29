class Api::TestMailUsersController < ApplicationController
  respond_to :json

  def create
    user = User.find_or_create_by_mail params[:mail]
    test_mail_user = TestMailUser.find_or_create_by_user_id user.id, test_mail_id: params[:test_mail_id]
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