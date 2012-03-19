class Api::TestMailsController < ApplicationController
  respond_to :json

  def create
    respond_to TestMail.create(params[:test_mail])
  end
end
