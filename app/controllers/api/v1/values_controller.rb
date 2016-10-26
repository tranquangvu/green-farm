class Api::V1::ValuesController < Api::ApiController
  before_action :check_device

  def create
    value = Value.new(value_params)

    if value.save
      render json: @response.success(value), status: :created
    else
      render json: @response.failed(value.errors.messages), status: :unprocessable_entity
    end
  end

  private

  def value_params
    params.require(:value).permit(:temp, :air_humid, :soil_humid, :brightness, :device_id)
  end

  def check_device
    unless Device.find(value_params[:device_id])
      render json: @response.failed(error: 'Device not found'), status: :not_found
    end
  end
end
