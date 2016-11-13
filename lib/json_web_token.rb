class JsonWebToken
  DEFAULT_SECRET = Rails.application.secrets.secret_key_base

  def self.encode(payload, secret = nil)
    JWT.encode(payload, secret || DEFAULT_SECRET)
  end

  def self.decode(token, secret = nil)
    return HashWithIndifferentAccess.new(JWT.decode(token, secret || DEFAULT_SECRET)[0])
  rescue
    nil
  end
end
