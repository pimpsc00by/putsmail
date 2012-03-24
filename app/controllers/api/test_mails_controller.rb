class Api::TestMailsController < ApplicationController
  respond_to :json

  def create
    test_mail = TestMail.create params[:test_mail]
    cookies[:last_test_mail_id] = {
      value: test_mail.id,
      expires: 10.years.from_now
    }
    respond_with test_mail, location: root_path
  end
end
