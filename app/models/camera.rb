class Camera < ApplicationRecord
  belongs_to :farm

  validates :ip, presence: true
  validates :port, presence: true
  validates :access_token, presence: true

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
