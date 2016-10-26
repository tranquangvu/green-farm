class Api::V1::DevicesController < Api::V1::ApiController
  def index
    devices = Device.all.map(&:ip)
    render json: @response.success(devices), status: :ok
  end
end