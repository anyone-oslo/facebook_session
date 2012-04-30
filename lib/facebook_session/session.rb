module FacebookSession
  class Session
    attr_accessor :user_id, :oauth_token, :algorithm, :issued_at

    class << self
      def base64_url_decode(string)
        encoded_string = string.gsub('-','+').gsub('_','/')
        encoded_string += '=' while (encoded_string.length % 4 != 0)
        Base64.decode64(encoded_string)
      end

      def parse_cookie(cookie)
        encoded_sig, payload = cookie.split('.')
        sig          = base64_url_decode(encoded_sig)
        session_data = JSON.parse(base64_url_decode(payload))
        session_data.symbolize_keys!

        expected_sig = OpenSSL::HMAC.digest(
          OpenSSL::Digest::Digest.new('sha256'),
          FacebookSession.application_secret,
          payload
        )

        if sig == expected_sig
          self.new(session_data)
        else
          nil
        end
      end
    end

    def initialize(session_data={})
      session_data.each do |key, value|
        self.send("#{key.to_s}=".to_sym, value) if self.respond_to?("#{key.to_s}=".to_sym)
      end
    end
  end
end