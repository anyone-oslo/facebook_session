require File.join(File.dirname(__FILE__), 'facebook_session/helper')
require File.join(File.dirname(__FILE__), 'facebook_session/session')
require File.join(File.dirname(__FILE__), 'facebook_session/signed_request')

module FacebookSession
  class << self

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
      self.config[:application_id]
    end

    def application_secret
      self.config[:application_secret]
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

ActionView::Base.send :include, FacebookSession::Helper
ActionController::Base.send :include, FacebookSession::Helper
