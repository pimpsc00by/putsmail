require "spec_helper"

describe GalleriesHelper do
  describe "#url2png_image_url" do
    it "returns the url" do
      Digest::MD5.stub hexdigest: "-security-hash-"
      Url2png.stub api_key: "-key-"
      expect(url2png_image_url("-url-")).to eq "http://api.url2png.com/v3/-key-/-security-hash-/FULL/-url-"
    end
  end
end
