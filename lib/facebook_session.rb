require File.join(File.dirname(__FILE__), 'facebook_session/helper')
require File.join(File.dirname(__FILE__), 'facebook_session/session')

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
  end
end

ActionView::Base.send :include, FacebookSession::Helper
ActionController::Base.send :include, FacebookSession::Helper