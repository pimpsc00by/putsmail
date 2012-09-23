require "spec_helper"

describe GalleriesController do
  
  let(:test_mail) { double "Test Mail" }
  let(:public_mails) { double "Public Mails" }

  before { TestMail.stub(public_mails: public_mails) }

  context "#index" do
    it "loads all test_mails" do
      public_mails.should_receive(:all)
      get "index"
    end

    it "loads total sent count" do
      public_mails.stub :all
      TestMail.should_receive :total_sent_count
      get "index"
    end
  end

  context "#show" do
    it "loads test_mail" do
      public_mails.should_receive(:find).with "0"
      get "show", id: 0
    end

    it "renders show with no layout" do
      public_mails.stub :find
      get "show", id: 0
      expect(response).to render_template(:show, layout: false)
    end
  end
end
