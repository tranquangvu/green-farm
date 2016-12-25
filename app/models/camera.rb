class Camera
  include Mongoid::Document
  include Mongoid::Timestamps

  #fields
  field :ip,           type: String
  field :port,         type: String
  field :access_token, type: String

  # associations
  belongs_to :farm

  # validations
  validates :ip,
            presence: true
  validates :port,
            presence: true
  validates :access_token,
            presence: true

  def host
    "#{ip}:#{port}"
  end

  def username
    account[:username]
  end

  def password
    account[:password]
  end

  def video_stream_url
    "#{host}/videostream.cgi?user=#{username}&pwd=#{password}"
  end

  def snapshot_url
    "#{host}/snapshot.cgi?user=#{username}&pwd=#{password}"
  end

  def up_url
    "#{host}/decoder_control.cgi?command=0&user=#{username}&pwd=#{password}"
  end

  def stop_up_url
    "#{host}/decoder_control.cgi?command=1&user=#{username}&pwd=#{password}"
  end

  def down_url
    "#{host}/decoder_control.cgi?command=2&user=#{username}&pwd=#{password}"
  end

  def stop_down_url
    "#{host}/decoder_control.cgi?command=3&user=#{username}&pwd=#{password}"
  end

  def left_url
    "#{host}/decoder_control.cgi?command=4&user=#{username}&pwd=#{password}"
  end

  def stop_left_url
    "#{host}/decoder_control.cgi?command=5&user=#{username}&pwd=#{password}"
  end

  def right_url
    "#{host}/decoder_control.cgi?command=6&user=#{username}&pwd=#{password}"
  end

  def stop_right_url
    "#{host}/decoder_control.cgi?command=7&user=#{username}&pwd=#{password}"
  end

  private

  def account
    JsonWebToken.decode(access_token)
  end
end
