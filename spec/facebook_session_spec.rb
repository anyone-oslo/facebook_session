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

  describe ".application_id" do
    subject { FacebookSession.application_id }

    context "when unconfigured" do
      it { is_expected.to eq(nil) }
    end

    context "when configured with a string" do
      before { FacebookSession.configure(application_id: "foo") }
      it { is_expected.to eq("foo") }
    end

    context "when configured with a proc" do
      before { FacebookSession.configure(application_id: -> { "foo" }) }
      it { is_expected.to eq("foo") }
    end
  end

  describe ".application_secret" do
    subject { FacebookSession.application_secret }

    context "when unconfigured" do
      it { is_expected.to eq(nil) }
    end

    context "when configured with a string" do
      before { FacebookSession.configure(application_secret: "foo") }
      it { is_expected.to eq("foo") }
    end

    context "when configured with a proc" do
      before { FacebookSession.configure(application_secret: -> { "foo" }) }
      it { is_expected.to eq("foo") }
    end
  end
end