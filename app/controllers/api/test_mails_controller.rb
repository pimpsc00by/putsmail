class Api::TestMailsController < ApplicationController
  respond_to :json

  def create
    test_mail = TestMail.create params[:test_mail]
    save_test_mail_cookie test_mail.token
    respond_with test_mail, location: api_test_mail_url(test_mail)
  end

  def update
    test_mail = TestMail.find_by_token cookies[:last_test_mail_id]
    if test_mail.update_attributes(params[:test_mail]) && test_mail.active_users.any?
      TestMailMailer.test_mail(test_mail).deliver
      test_mail.increment! :sent_count
    end
    respond_with test_mail
  end
  
  def add_to_gallery
    test_mail = TestMail.find_by_token cookies[:last_test_mail_id]
    test_mail.update_attributes(params[:test_mail])
    test_mail.in_gallery = true
    respond_with test_mail
  end

  def show
    test_mail = TestMail.find_by_token(params[:id])
    save_test_mail_cookie test_mail.token
    respond_with test_mail
  end
  
  private
  
  def save_test_mail_cookie token
    cookies[:last_test_mail_id] = {value: token, expires: 3.months.from_now}
  end
end
