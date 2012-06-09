class GalleriesController < ApplicationController
  def index
    @emails = TestMail.limit(20).order('updated_at DESC')
  end
  
  def show
    @email = TestMail.find params[:id]
    render 'show', layout: false
  end
end
