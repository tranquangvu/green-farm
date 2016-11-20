class Api::V1::FarmsController < Api::V1::ApiController
  before_action :set_farm, only: [:show]

  def index
    @farms = current_user.farms
    response_data = @farms.as_json( only: [:name, :address],
                                    methods: [:id] )
    render json: @response.success(response_data), status: :ok
  end

  def show
    if @farm
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
    else
      render json: @response.failure({ error: 'Not found' }), status: :not_found
    end
  end

  private

  def set_farm
    @farm ||= Farm.find(params[:id])
  end
end
