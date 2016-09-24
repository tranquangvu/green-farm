class Camera < ApplicationRecord
  def host
    "#{ip}:#{port}"
  end

  def username
    account[:username]
  end

  def password
    account[:password]
  end

  private

  def account
    JsonWebToken.decode(access_token)
  end
end
