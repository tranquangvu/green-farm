class Api::V1::DevicesController < Api::ApiController
  def index
    devices = Device.all.map do |device|
      { id: device.id.to_s, ip: device.ip }
    end
    render json: @response.success(devices), status: :ok
  end
end