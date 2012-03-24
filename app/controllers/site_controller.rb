class SiteController < ApplicationController
  def index
    @test_mail = TestMail.find_or_initialize_by_id cookies[:last_test_mail_id]
    @last_test_mail_id = cookies[:last_test_mail_id]
  end
end
