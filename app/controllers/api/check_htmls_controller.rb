require "check_html"
class Api::CheckHtmlsController < ApplicationController
  respond_to :json

  def create
    respond_with CheckHtml.check_it(params[:test_mail][:body]), location: root_path
  end
end
