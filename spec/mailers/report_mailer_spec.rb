require "spec_helper"

describe ReportMailer do
  describe ".deliver_summary_mails" do
    let(:report) do
      FactoryGirl.create(:report)
    end

    let!(:warnings) do
      2.times.map do |i|
        FactoryGirl.create(:warning, :report => report, :modified_at => i.hours.ago)
      end
    end

    let(:mails) do
      ActionMailer::Base.deliveries
    end

    it "sends mails about the recent changes to each modifier" do
      ReportMailer.deliver_summary_mails
      mails.should have(2).mail
      mails[0].subject.should == "CodeHunter Report on #{Date.today}"
      mails[1].subject.should == "CodeHunter Report on #{Date.today}"
      mails[0].from.should == ["from@example.com"]
      mails[1].from.should == ["from@example.com"]
      mails[0].to.should == ["1@example.com"]
      mails[1].to.should == ["2@example.com"]
      mails[0].body.should_not be_empty
      mails[1].body.should_not be_empty
    end
  end
end
