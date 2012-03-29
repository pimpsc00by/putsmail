class Api::TestMailsController < ApplicationController
  respond_to :json

  def create
    test_mail = TestMail.create params[:test_mail]
    cookies[:last_test_mail_id] = {
      value: test_mail.token,
      expires: 3.months.from_now
    }
    respond_with test_mail, location: api_test_mail_url(test_mail)
  end

  def update
    test_mail = TestMail.find(params[:id])
    test_mail.body = params[:test_mail][:body]
    test_mail.subject = params[:test_mail][:subject]
    if test_mail.save and !test_mail.active_users.empty?
      TestMailMailer.test_mail(test_mail).deliver
      test_mail.increment! :sent_count
    end
    respond_with test_mail
  end

  def show
    test_mail = TestMail.where("token lIKE '%#{params[:id]}%'").first
    respond_with test_mail
  end
end
