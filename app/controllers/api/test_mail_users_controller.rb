class Api::TestMailUsersController < ApplicationController
  respond_to :json

  before_filter :load_test_mail

  def create
    user = User.find_or_create_by_mail params[:mail]
    test_mail_user = @test_mail.test_mail_users.create user: user
    respond_with :api, test_mail_user
  end

  def show
    test_mail_user = @test_mail.test_mail_users.find params[:id]
    respond_with test_mail_user
  end

  def index
    respond_with @test_mail.test_mail_users.all
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
    @test_mail = TestMail.find_by_token cookies[:last_test_mail_id]
  end
end
