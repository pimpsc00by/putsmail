require "spec_helper"

describe Api::CheckHtmlsController do
  describe "#create" do
    it "checks html" do
      CheckHtml.should_receive(:check_it).with("test")
      post "create", test_mail: {body: "test"}
    end
  end
end 
