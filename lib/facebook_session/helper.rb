module FacebookSession
  module Helper

    def facebook_session
      return @facebook_session if @facebook_session
      raise 'FacebookSession not configured!' unless FacebookSession.config?
      if facebook_cookie = cookies["fbsr_#{FacebookSession.application_id}"]
        @facebook_session = FacebookSession::Session.parse_cookie(facebook_cookie)
      end
    end

    def facebook_session?
      self.facebook_session ? true : false
    end

  end
end
