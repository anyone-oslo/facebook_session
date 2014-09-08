require 'spec_helper'

class TestController
  include FacebookSession::Helper
  def initialize(options = {})
    @fb_session = options[:fb_session]
    @signed_request = options[:signed_request]
  end

  def cookies
    { "fbsr_foo" => @fb_session }
  end

  def params
    { signed_request: @signed_request }
  end
end

describe FacebookSession::Helper do
  before(:all) { FacebookSession.configure(application_id: "foo", application_secret: "bar") }

  let(:json)       { '{"user_id": "123", "oauth_token": "abc", "algorithm": "sha256", "issued_at": "2014"}' }
  let(:payload)    { Base64.urlsafe_encode64(json) }
  let(:digest)     { Base64.urlsafe_encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), "bar", payload)) }
  let(:message)    { "#{digest}.#{payload}" }
  let(:controller) { TestController.new }

  describe "#facebook_session" do
    subject { controller.facebook_session }

    context "without session data" do
      it { is_expected.to eq(nil) }
    end

    context "with session data" do
      let(:controller) { TestController.new(fb_session: message) }
      it { is_expected.to be_a(FacebookSession::Session) }
      it "should decode the message" do
        expect(subject.user_id).to eq("123")
      end
    end
  end

  describe "#facebook_session?" do
    subject { controller.facebook_session? }

    context "without session data" do
      it { is_expected.to eq(false) }
    end

    context "with session data" do
      let(:controller) { TestController.new(fb_session: message) }
      it { is_expected.to eq(true) }
    end
  end

  describe "#facebook_signed_request" do
    subject { controller.facebook_signed_request }

    context "without a signed request" do
      it { is_expected.to eq(nil) }
    end

    context "with a signed request" do
      let(:controller) { TestController.new(signed_request: message) }
      it { is_expected.to be_a(FacebookSession::SignedRequest) }
      it "should decode the message" do
        expect(subject.user_id).to eq("123")
      end
    end
  end

  describe "#facebook_signed_request?" do
    subject { controller.facebook_signed_request? }

    context "without a signed request" do
      it { is_expected.to eq(false) }
    end

    context "with a signed request" do
      let(:controller) { TestController.new(signed_request: message) }
      it { is_expected.to eq(true) }
    end
  end
end
