class TestMailsController < ApplicationController
  def show
    @email = TestMail.find params[:id]
    render 'show', layout: false
  end
end
