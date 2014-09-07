module FacebookSession
  class SignedRequest
    attr_accessor :code, :algorithm, :issued_at, :user_id, :user, :oauth_token, :expires, :app_data, :page

    class << self
      def parse_request(request)
        self.new(FacebookSession.message_decoder.decode(request))
      end
    end

    def initialize(request_data={})
      request_data.each do |key, value|
        self.send("#{key.to_s}=".to_sym, value) if self.respond_to?("#{key.to_s}=".to_sym)
      end
    end
  end
end
