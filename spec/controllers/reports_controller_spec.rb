require "spec_helper"

describe ReportsController do
  describe "#show" do
    subject do
      get :show, :id => Report.create.id
    end
    it { should be_ok }
  end

  describe "#latest" do
    subject do
      get :latest
    end
    it { should be_ok }
  end

  describe "#create" do
    subject do
      post :create, :warnings => warnings
    end

    context "when given not parsable params[:warnings]" do
      let(:warnings) do
        ""
      end
      it { should be_bad_request }
    end

    context "when not given params[:warnings]" do
      let(:warnings) do
        nil
      end
      it { should be_bad_request }
    end

    context "when given valid params[:warnings]" do
      let(:warnings) do
        [
          {
            :service     => "rails_best_practices",
            :line        => 8,
            :path        => "app/controllers/sessions_controller.rb",
            :message     => "remove unused methods (SessionsController#destroy)",
            :sha1        => "967ccc657ec1f030b61c05f29d97f6c018429205",
            :author      => "Ryo Nakamura",
            :email       => "r7kamura@gmail.com",
            :modified_at => 1356370446
          }
        ].to_json
      end

      it { should be_ok }

      it "creates Warning records" do
        subject
        Warning.should have(1).warning
      end
    end
  end
end
