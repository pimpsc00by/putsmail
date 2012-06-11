class GalleriesController < ApplicationController
  def index
    @emails = TestMail.public_emails
    @total_sent_count = TestMail.total_sent_count
  end
end
