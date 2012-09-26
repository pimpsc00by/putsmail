require "spec_helper"

describe TestMailUser do
  subject(:test_mail_user) { TestMailUser.new }
  let(:user) { User.new }

  before do
    test_mail_user.user = user
  end

  describe "#as_json" do
    its(:to_json) { should include("user") }
  end

end
