class CameraCreating
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :ip, :port, :username, :password

  def initialize(options)
    @ip       = options[:ip]
    @port     = options[:port]
    @username = options[:username]
    @password = options[:password]
  end

  def save
    Camera.create(
      ip: ip,
      port: port,
      access_token: JsonWebToken.encode({
        username: username,
        password: password
      })
    )
  end

  def self.create(options)
    self.new(options).save
  end

  def persisted?
    false
  end
end