module FacebookSession
  class SignedRequest < DecodeableStruct
    attr_accessor :user_id, :oauth_token, :algorithm, :issued_at
    attr_accessor :code, :user, :expires, :app_data, :page
  end
end
