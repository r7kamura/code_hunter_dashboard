require "spec_helper"

describe Report do
  before do
    FactoryGirl.create(:warning, :report => previous)
    FactoryGirl.create(:warning, :report => current)
  end

  let(:current) do
    FactoryGirl.create(:report, :created_at => 10.minutes.ago)
  end

  let(:previous) do
    FactoryGirl.create(:report, :created_at => 11.minutes.ago)
  end

  describe "#added_warning" do
    it "returns added warnings" do
      current.added_warnings.should have(1).warning
    end
  end

  describe "#removed_warning" do
    it "returns removed warnings" do
      current.removed_warnings.should have(1).warning
    end
  end
end
