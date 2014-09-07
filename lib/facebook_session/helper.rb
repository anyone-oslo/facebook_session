module FacebookSession
  module Helper

    def facebook_session
      if message = cookies["fbsr_#{FacebookSession.application_id}"]
        @facebook_session ||= FacebookSession::Session.decode(message)
      end
    end

    def facebook_session?
      self.facebook_session ? true : false
    end

    def facebook_signed_request
      if message = params[:signed_request]
        @facebook_signed_request ||= FacebookSession::SignedRequest.decode(message)
      end
    end

    def facebook_signed_request?
      self.facebook_signed_request ? true : false
    end
  end
end
