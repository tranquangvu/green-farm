class API::V1::ApiController < ApplicationController
  before_action :authenticate

  private

  def authenticate
    token = request.headers['Authorization']
    content_type = request.headers['Content-Type']

    unless token == Rails.application.secrets.bot_connect_token && content_type == 'application/json'
      render json: { errors: 'Access denied!' }, status: :unauthorized
    end
  end
end