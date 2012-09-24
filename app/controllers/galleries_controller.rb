class GalleriesController < ApplicationController
  def index
    @mails = TestMail.public_mails.all
    @total_sent_count = TestMail.total_sent_count
  end
  
  def show
    @mail = TestMail.public_mails.find params[:id]
    render "show", layout: false
  end
end
