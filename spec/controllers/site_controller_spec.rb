require "spec_helper"

describe SiteController do

  describe "#index" do
    it "returns http success" do
      get "index"
      expect(response).to be_success
    end
  end

  describe "#old_index" do
    it "redirects to the tests/:token path" do
      get "old_index", token: "0"

      expect(response).to redirect_to("/tests/0")
    end
  end

end
