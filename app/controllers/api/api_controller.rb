class Api::ApiController < ActionController::Base
  before_action :set_response
  before_action :authenticate!

  attr_reader :current_user

  protected

  def authenticate!
    header_uid ? authenticate_user! : authenticate_server!
  end

  def authenticate_user!
    return render_unauthorized unless valid_user_id_in_token?
    @current_user = User.find(auth_token[:user_id])
  rescue JWT::VerificationError, JWT::DecodeError
    render_unauthorized
  end

  def authenticate_server!
    render_unauthorized unless header_token == Rails.application.secrets.server_connect_token
  end

  private

  def header_authorization
    @header_authorization ||= if request.headers['Authorization'].present?
      request.headers['Authorization'].split(' ')
    end
  end

  def header_token_type
    return unless header_authorization.try(:count) > 1
    @header_token_type ||= header_authorization.first
  end

  def header_token
    @header_token ||= header_authorization.last
  end

  def header_uid
    @header_uid ||= request.headers['uid']
  end

  def auth_token
    secret = UidSecret.find_by(uid: header_uid).try(:secret)
    @auth_token ||= JsonWebToken.decode(header_token, secret)
  end

  def valid_user_id_in_token?
    header_token_type == 'Bearer' && header_token && auth_token && auth_token[:user_id]
  end

  def render_unauthorized
    render json: @response.failure(error: 'Not Authenticated'), status: :unauthorized
  end

  def set_response
    @response = ApiResponse.new
  end
end
