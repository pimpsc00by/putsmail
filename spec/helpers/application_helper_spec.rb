require "spec_helper"

describe ApplicationHelper do
  describe "#dispatcher_tag" do
    it "returns the meta tag" do
      controller.stub class: ApplicationController
      controller.stub action_name: "index"
      expect(dispatcher_tag).to eq "<meta name=\"page\" content=\"application#index\" />"
    end
  end
end
