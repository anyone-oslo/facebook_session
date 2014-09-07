module FacebookSession
  class DecodeableStruct
    class << self
      def decode(message)
        self.new(FacebookSession.message_decoder.decode(message))
      end
    end

    def initialize(data={})
      data.each do |key, value|
        if self.respond_to?("#{key.to_s}=".to_sym)
          self.send("#{key.to_s}=".to_sym, value)
        end
      end
    end
  end
end