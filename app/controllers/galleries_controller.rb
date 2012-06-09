class GalleriesController < ApplicationController
  def index
    @emails = TestMail.where('body != \'\' AND body IS NOT NULL').limit(21).order('updated_at DESC')
  end
  
  def show
    @email = TestMail.find params[:id]
    render 'show', layout: false
  end
end
