module FacebookSession
  class Session < DecodeableStruct
    attr_accessor :user_id, :oauth_token, :algorithm, :issued_at
  end
end
