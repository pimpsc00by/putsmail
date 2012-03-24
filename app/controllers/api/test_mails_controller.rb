class Api::TestMailsController < ApplicationController
  respond_to :json

  def create
    test_mail = TestMail.create params[:test_mail]
    cookies[:last_test_mail_id] = {
      value: test_mail.id,
      expires: 10.years.from_now
    }
    respond_with test_mail
  end

  def update
    test_mail = TestMail.find(params[:id])
    test_mail.body = params[:test_mail][:body]
    test_mail.subject = params[:test_mail][:subject]
    test_mail.test_mail_users.delete_all
    params[:users].to_a.each do | user_data |
      user = User.find_or_create_by_mail user_data[:mail]
      if !user.new_record?
        test_mail.test_mail_users.build :user => user
      end
    end
    test_mail.save
    respond_with test_mail
  end

  def show
    respond_with TestMail.find(params[:id])
  end
end
