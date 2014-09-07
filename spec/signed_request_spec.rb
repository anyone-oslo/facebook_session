require 'spec_helper'

describe FacebookSession::SignedRequest do
  before(:all) { FacebookSession.configure(application_id: "foo", application_secret: "bar") }

  let(:json)    { '{"user_id": "123", "oauth_token": "abc", "algorithm": "sha256", "issued_at": "2014", "code": "code", "user": "user", "expires": "expires", "app_data": "app_data", "page": "page"}' }
  let(:payload) { Base64.urlsafe_encode64(json) }
  let(:digest)  { Base64.urlsafe_encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), "bar", payload)) }
  let(:message) { "#{digest}.#{payload}" }

  describe ".decode" do
    subject { FacebookSession::SignedRequest.decode(message) }

    context "with a valid message" do
      it { is_expected.to be_a(FacebookSession::SignedRequest) }
      it "should recieve the data" do
        expect(subject.user_id).to eq("123")
        expect(subject.oauth_token).to eq("abc")
        expect(subject.algorithm).to eq("sha256")
        expect(subject.issued_at).to eq("2014")
        expect(subject.code).to eq("code")
        expect(subject.user).to eq("user")
        expect(subject.expires).to eq("expires")
        expect(subject.app_data).to eq("app_data")
        expect(subject.page).to eq("page")
      end
    end
  end
end
