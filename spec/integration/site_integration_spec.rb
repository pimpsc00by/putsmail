#coding: utf-8
require 'spec_helper'

describe "Site", :type                      => :request do
  describe "GET index" do
    it "should access index properly" do
      # visit root_path
      # page.should have_selector("form#form_test_email")
    end
  end
  describe "Test e-mail" do
    it "send the test email" do
      # visit root_path
      # assert_difference "TestMail.count" => +1, "TestMailUser.count" => +1, "User.count" => +1 do
      #   within("form#form_test_email") do
      #     fill_in 'test_mail_recipients_0', :with      => "pablo@pablocantero.com"
      #     fill_in 'test_mail_subject', :with => "Hey"
      #     fill_in 'test_mail_body', :with    => "Hey ho, let's go"
      #     click_button "Send"
      #   end
      # end
    end
  end
end
