class Api::V1::FarmsController < Api::ApiController
  before_action :set_farm, only: [:show, :sensor_data]

  def index
    @farms = current_user.farms
    response_data = @farms.as_json(only: [:name, :address],
                                   methods: [:id])
    render json: @response.success(response_data), status: :ok
  end

  def show
    response_data = @farm.as_json(
      except: [:_id],
      methods: [:id],
      include: {
        camera: {
          only: [:ip],
          methods: [:port, :username, :password]
        }
      }
    )
    render json: @response.success(response_data), status: :ok
  end

  def sensor_data
    response_data = @farm.values.where(
      :created_at.gte => params[:start_time],
      :created_at.lte => params[:end_time]
    ).as_json(
      except: [:_id, :created_at, :updated_at, :device_id],
      methods: [:time]
    )
    render json: @response.success(response_data), status: :ok
  end

  private

  def set_farm
    @farm ||= Farm.find(params[:id])
    render json: @response.failure({ error: 'Not found' }), status: :not_found unless @farm
  end
end
