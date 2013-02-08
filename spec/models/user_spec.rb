require "spec_helper"

describe User do
  let(:user) do
    User.new
  end

  describe "#emails=" do
    it "is set after joined with comma" do
      user.emails = %w[a@example.com b@example.com]
      user[:emails].should == "a@example.com,b@example.com"
    end
  end

  describe "#emails" do
    it "returns emails as Array" do
      user[:emails] = "a@example.com,b@example.com"
      user.emails.should == %w[a@example.com b@example.com]
    end
  end
end
