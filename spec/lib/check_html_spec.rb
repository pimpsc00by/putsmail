require 'spec_helper'
require 'check_html'

describe CheckHtml do
    it "checks the HTML" do
      result = CheckHtml.check_it "hello world"
      result.body.should eq "hello world"
      result.warnings.should eq []
  end
end