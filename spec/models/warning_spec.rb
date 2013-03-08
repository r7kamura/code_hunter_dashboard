require "spec_helper"

describe Warning do
  describe ".recently_modified" do
    let!(:warnings) do
      3.times.map {|i| Warning.create(:modified_at => i )}
    end

    it "returns warnings in the order which they modified" do
      Warning.recently_modified.should == warnings.reverse
    end
  end
end
