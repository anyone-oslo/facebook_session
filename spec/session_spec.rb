require 'spec_helper'

describe FacebookSession::Session do
  before(:all) { FacebookSession.configure(application_id: "foo", application_secret: "bar") }

  let(:json)    { '{"user_id": "123", "oauth_token": "abc", "algorithm": "sha256", "issued_at": "2014"}' }
  let(:payload) { Base64.urlsafe_encode64(json) }
  let(:digest)  { Base64.urlsafe_encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), "bar", payload)) }
  let(:message) { "#{digest}.#{payload}" }

  describe ".decode" do
    subject { FacebookSession::Session.decode(message) }

    context "with a valid message" do
      it { is_expected.to be_a(FacebookSession::Session) }
      it "should recieve the data" do
        expect(subject.user_id).to eq("123")
        expect(subject.oauth_token).to eq("abc")
        expect(subject.algorithm).to eq("sha256")
        expect(subject.issued_at).to eq("2014")
      end
    end
  end
end
