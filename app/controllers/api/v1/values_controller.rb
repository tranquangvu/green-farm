class Api::V1::ValuesController < Api::ApiController
  before_action :check_device, only: [:create]

  def create
    value = Value.new(value_params)

    if value.save
      render json: @response.success(value), status: :created
    else
      render json: @response.failure(value.errors.messages), status: :unprocessable_entity
    end
  end

  def create_list
    begin
      values = Value.create!(value_list_params[:list])
      render json: @response.success(values), status: :created
    rescue Exception => e
      render json: @response.failure(error: e), status: :unprocessable_entity
    end
  end

  private

  def value_params
    params.require(:value).permit(:temperature, :humidity, :soil_moisture, :light, :device_id)
  end

  def value_list_params
    params.require(:value).permit(:list => [:temperature, :humidity, :soil_moisture, :light, :device_id])
  end

  def check_device
    unless Device.find(value_params[:device_id])
      render json: @response.failure(error: 'Device not found'), status: :not_found
    end
  end
end
