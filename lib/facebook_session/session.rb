module FacebookSession
  class Session
    attr_accessor :user_id, :oauth_token, :algorithm, :issued_at

    class << self
      def parse_cookie(cookie)
        self.new(FacebookSession.message_decoder.decode(cookie))
      end
    end

    def initialize(session_data={})
      session_data.each do |key, value|
        self.send("#{key.to_s}=".to_sym, value) if self.respond_to?("#{key.to_s}=".to_sym)
      end
    end
  end
end
