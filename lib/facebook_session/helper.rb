module FacebookSession
  module Helper

    def facebook_session
      return @facebook_session if @facebook_session
      raise 'FacebookSession not configured!' unless FacebookSession.config?
      if facebook_cookie = cookies["fbsr_#{FacebookSession.application_id}"]
        @facebook_session = FacebookSession::Session.decode(facebook_cookie)
      end
    end

    def facebook_session?
      self.facebook_session ? true : false
    end

    def facebook_signed_request
      return @facebook_signed_request if @facebook_signed_request
      raise 'FacebookSession not configured!' unless FacebookSession.config?
      if facebook_signed_request = params[:signed_request]
        @facebook_signed_request = FacebookSession::SignedRequest.decode(facebook_signed_request)
      end
    end

    def facebook_signed_request?
      self.facebook_signed_request ? true : false
    end
  end
end
