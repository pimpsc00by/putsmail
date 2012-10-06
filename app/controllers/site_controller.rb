class SiteController < ApplicationController
  def index
    @last_test_mail_id = cookies[:last_test_mail_id]
    @total_sent_count  = TestMail.total_sent_count
  end

  def old_gallery
    redirect_to galleries_path, status: 301
  end

  def old_index
    redirect_to "/tests/#{params[:token]}", status: 301
  end

  def old_gallery_item
    redirect_to "/test_mails/#{params[:id]}", status: 301
  end
end

