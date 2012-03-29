class Api::TestMailUsersController < ApplicationController
  respond_to :json

  before_filter :load_test_mail

  def create
    user = User.find_or_create_by_mail params[:mail]
    test_mail_user = @test_mail.test_mail_users.create user_id: user.id, test_mail_id: params[:test_mail_id]
    respond_with test_mail_user, location: api_test_mail_user_url(test_mail_user)
  end
  
  def show    
    test_mail_user = @test_mail.test_mail_users.find params[:id]
    respond_with test_mail_user
  end
  
  def index
    respond_with @test_mail.test_mail_users
  end
  
  def update
    test_mail_user = @test_mail.test_mail_users.find params[:id]
    respond_with test_mail_user.update_attributes(params[:test_mail_user])
  end
  
  def destroy
    respond_with @test_mail.test_mail_users.destroy(params[:id])    
  end
  
  private
  def load_test_mail
    test_mail_id = cookies[:last_test_mail_id]
    @test_mail = TestMail.find test_mail_id
  end
end