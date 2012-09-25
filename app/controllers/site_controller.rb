class SiteController < ApplicationController
  def index
    @last_test_mail_id = cookies[:last_test_mail_id]
    @total_sent_count = TestMail.total_sent_count
  end

  def old_index
    new_path = if token = params[:token]
      "/tests/#{token}"
    else
      "/"
    end
    redirect_to new_path, status: 301
  end
end

