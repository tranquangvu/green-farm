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

  def generate_fields
    {
      ip: ip,
      port: port,
      access_token: JsonWebToken.encode({
        username: username,
        password: password
      })
    }
  end

  def self.build(options)
    new(options).generate_fields
  end

  def persisted?
    false
  end
end
