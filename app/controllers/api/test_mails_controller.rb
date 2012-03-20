class Api::TestMailsController < ApplicationController
  respond_to :json

  def create
    # @test_mail = TestMail.create(params[:test_mail])
    # respond_with @test_mail, location: root_path # api_test_mail_path(@test_mail)
    respond_with TestMail.create(params[:test_mail]), location: root_path
  end
end
