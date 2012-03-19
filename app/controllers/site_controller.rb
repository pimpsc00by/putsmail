class SiteController < ApplicationController
  def index
    @test_mail = TestMail.new
  end
end
