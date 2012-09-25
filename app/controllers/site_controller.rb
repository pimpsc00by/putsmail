class SiteController < ApplicationController
  def index
    @last_test_mail_id = cookies[:last_test_mail_id]
    @total_sent_count = TestMail.total_sent_count
  end
end

