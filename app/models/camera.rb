class Camera
  include Mongoid::Document
  include Mongoid::Timestamps

  #fields
  field :ip, type: String
  field :port, type: String
  field :access_token, type: String

  # associations
  belongs_to :farm

  # validations
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
