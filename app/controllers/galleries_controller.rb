class GalleriesController < ApplicationController
  def index
    @emails = TestMail.public_emails
  end
end
