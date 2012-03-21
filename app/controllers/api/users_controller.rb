class Api::UsersController < ApplicationController
  respond_to :json

  def index
    respond_with User.all
  end
  
  def create
    respond_with User.find_or_create_by_mail(params[:user]), location: root_path
  end
end
