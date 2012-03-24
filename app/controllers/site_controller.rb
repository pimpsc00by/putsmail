class SiteController < ApplicationController
  def index
    @test_mail = TestMail.find_or_initialize_by_id cookies[:last_test_mail_id]
    @last_recipients = @test_mail.convert_users_into_recipients!
  end
end
