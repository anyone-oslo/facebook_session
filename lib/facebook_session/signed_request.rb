module FacebookSession
  class SignedRequest
    attr_accessor :code, :algorithm, :issued_at, :user_id, :user, :oauth_token, :expires, :app_data, :page

    class << self
      def parse_request(request)
        if request_data = FacebookSession.decode_payload(request)
          self.new(request_data)
        else
          nil
        end
      end
    end

    def initialize(request_data={})
      request_data.each do |key, value|
        self.send("#{key.to_s}=".to_sym, value) if self.respond_to?("#{key.to_s}=".to_sym)
      end
    end
  end
end
