# encoding: utf-8

module FacebookSession
  class MessageDecoder
    def initialize(secret)
      @secret = secret
    end

    def decode(string)
      encoded_digest, payload = string.split('.')
      digest = decode_base64(encoded_digest)

      if valid_digest?(payload, digest)
        parse_payload(payload)
      else
        raise FacebookSession::InvalidSignature
      end
    end

    private

    def decode_base64(str)
      str += '=' while str.length % 4 != 0 # Pad string with =
      Base64.urlsafe_decode64(str)
    end

    def parse_payload(payload)
      parsed_payload = JSON.parse(decode_base64(payload))
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