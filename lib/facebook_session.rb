require 'base64'

require File.join(File.dirname(__FILE__), 'facebook_session/decodeable_struct')
require File.join(File.dirname(__FILE__), 'facebook_session/helper')
require File.join(File.dirname(__FILE__), 'facebook_session/message_decoder')
require File.join(File.dirname(__FILE__), 'facebook_session/session')
require File.join(File.dirname(__FILE__), 'facebook_session/railtie')
require File.join(File.dirname(__FILE__), 'facebook_session/signed_request')

module FacebookSession
  class << self

    def clear_config!
      @@config = nil
    end

    def config?
      config[:application_id] && config[:application_secret] ? true : false
    end

    def configure(options={})
      options.each do |key, val|
        config[key.to_sym] = val
      end
      config
    end

    def application_id
      if config[:application_id].kind_of?(Proc)
        config[:application_id].call
      else
        config[:application_id]
      end
    end

    def application_secret
      if config[:application_secret].kind_of?(Proc)
        config[:application_secret].call
      else
        config[:application_secret]
      end
    end

    def message_decoder
      FacebookSession::MessageDecoder.new(application_secret)
    end

    private

    def config
      @@config ||= {}
    end
  end
end

