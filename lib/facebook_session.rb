require File.join(File.dirname(__FILE__), 'facebook_session/helper')
require File.join(File.dirname(__FILE__), 'facebook_session/session')
require File.join(File.dirname(__FILE__), 'facebook_session/railtie')
require File.join(File.dirname(__FILE__), 'facebook_session/signed_request')

module FacebookSession
  class << self

    def clear_config!
      @@config = nil
    end

    def config
      @@config ||= {}
    end

    def config?
      self.config[:application_id] && self.config[:application_secret] ? true : false
    end

    def configure(options={})
      options.each do |key, val|
        self.config[key.to_sym] = val
      end
      self.config
    end

    def application_id
      if self.config[:application_id].kind_of?(Proc)
        self.config[:application_id].call
      else
        self.config[:application_id]
      end
    end

    def application_secret
      if self.config[:application_secret].kind_of?(Proc)
        self.config[:application_secret].call
      else
        self.config[:application_secret]
      end
    end

    def base64_url_decode(string)
      encoded_string = string.gsub('-','+').gsub('_','/')
      encoded_string += '=' while (encoded_string.length % 4 != 0)
      Base64.decode64(encoded_string)
    end

    def decode_payload(string)
      encoded_sig, payload = string.split('.')
      sig             = base64_url_decode(encoded_sig)
      decoded_payload = JSON.parse(base64_url_decode(payload))
      decoded_payload.symbolize_keys!

      expected_sig = OpenSSL::HMAC.digest(
        OpenSSL::Digest.new('sha256'),
        FacebookSession.application_secret,
        payload
      )

      if sig == expected_sig
        decoded_payload
      else
        nil
      end
    end

  end
end

