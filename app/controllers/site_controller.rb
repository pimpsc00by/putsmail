class SiteController < ApplicationController
  def index
    @last_test_mail_id = cookies[:last_test_mail_id]
  end
end
