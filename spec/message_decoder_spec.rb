require 'spec_helper'

describe FacebookSession::MessageDecoder do
  let(:secret)   { "topsecret" }
  let(:verifier) { FacebookSession::MessageDecoder.new(secret) }
  let(:json)     { '{"foo": "bar"}' }
  let(:payload)  { Base64.urlsafe_encode64(json) }
  let(:digest)   { Base64.urlsafe_encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), secret, payload)) }
  let(:message)  { "#{digest}.#{payload}" }

  describe "#decode" do
    subject { verifier.decode(message) }

    context "with valid data" do
      it { is_expected.to eq({foo: "bar"}) }
    end

    context "with invalid digest" do
      let(:digest) { "1639a467ae544a4a9b4a5623fe56a2f93276087b" }
      it "should raise an error" do
        expect { subject }.to raise_error(FacebookSession::InvalidSignature)
      end
    end
  end
end