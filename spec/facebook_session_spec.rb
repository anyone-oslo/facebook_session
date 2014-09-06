require 'spec_helper'

describe FacebookSession do
  before(:each) do
    FacebookSession.clear_config!
  end

  describe ".config?" do
    subject { FacebookSession.config? }

    context "when no config is set" do
      it { is_expected.to eq(false) }
    end

    context "when one option is missing" do
      before { FacebookSession.configure(application_id: "foo") }
      it { is_expected.to eq(false) }
    end

    context "when both options are set" do
      before { FacebookSession.configure(application_id: "foo", application_secret: "bar") }
      it { is_expected.to eq(true) }
    end
  end
end