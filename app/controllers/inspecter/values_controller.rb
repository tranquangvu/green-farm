class Inspecter::ValuesController < Inspecter::BaseController
  before_action :set_farm

  [:temperature, :humidity, :soil_moisture, :light].each do |prop|
    define_method("#{prop}_of_date") do
      if !@farm || params[:year].blank? || params[:month].blank? || params[:day].blank?
        return invalid_params
      else
        query_result = Value.get_value_of_date(
          device_id: @farm.device.id,
          year: params[:year].to_i,
          month: params[:month].to_i,
          day: params[:day].to_i,
          prop: prop
        )
        response_data = query_result.map do |record|
          record[prop] = record[prop].round(2)
          record
        end
        render json: response_data.as_json(except: [:_id, :device_id]), status: :ok
      end
    end
  end

  [:temperature, :humidity, :soil_moisture, :light].each do |prop|
    define_method("#{prop}_of_month") do
      if !@farm || params[:year].blank? || params[:month].blank?
        return invalid_params
      else
        query_result = Value.avg_in_minute_of_month(
          device_id: @farm.device.id,
          year: params[:year].to_i,
          month: params[:month].to_i,
          prop: prop
        )
        response_data = query_result.map do |record|
          {
            "year" => record[:_id][:year],
            "month" => record[:_id][:month],
            "hour" => record[:_id][:hour],
            "minute" => record[:_id][:minute],
            "#{prop}" => record[prop].round(2)
          }
        end
        render json: response_data, status: :ok
      end
    end
  end

  private

  def set_farm
    return invalid_params if params[:farm_id].blank?
    @farm = Farm.find(params[:farm_id])
  end

  def invalid_params
    render json: { error: 'Invalid params' }, status: :bad_request
  end
end
