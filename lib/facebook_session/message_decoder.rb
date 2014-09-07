# encoding: utf-8

module FacebookSession
  class MessageDecoder
    class InvalidSignature < StandardError; end

    def initialize(secret)
      @secret = secret
    end

    def decode(string)
      encoded_digest, payload = string.split('.')
      digest = Base64.urlsafe_decode64(encoded_digest)

      if valid_digest?(payload, digest)
        parse_payload(payload)
      else
        raise InvalidSignature
      end
    end

    private

    def parse_payload(payload)
      parsed_payload = JSON.parse(Base64.urlsafe_decode64(payload))
      parsed_payload.symbolize_keys!
      parsed_payload
    end

    def secure_compare(a, b)
      return false unless a.bytesize == b.bytesize

      l = a.unpack "C#{a.bytesize}"

      res = 0
      b.each_byte { |byte| res |= byte ^ l.shift }
      res == 0
    end

    def generate_digest(data)
      require 'openssl' unless defined?(OpenSSL)
      OpenSSL::HMAC.digest(
        OpenSSL::Digest.new('sha256'),
        @secret,
        data
      )
    end

    def valid_digest?(data, digest)
      data.present? && digest.present? && secure_compare(digest, generate_digest(data))
    end
  end
end