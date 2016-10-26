class Api::ApiController < ActionController::Base
  before_action :authenticate
  before_action :set_response

  private

  def authenticate
    token        = request.headers['Authorization']
    content_type = request.headers['Content-Type']

    return render_unauthorized unless token == Rails.application.secrets.server_connect_token
    render_unauthorized unless request.get? || content_type == 'application/json'
  end

  def render_unauthorized
    render json: { errors: 'Access denied!' }, status: :unauthorized
  end

  def set_response
    @response = ApiResponse.new()
  end
end
