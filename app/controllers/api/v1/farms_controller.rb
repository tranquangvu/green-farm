class Api::V1::FarmsController < Api::ApiController
  include CarrierwaveBase64

  before_action :set_farm, except: [:index]

  def index
    response_data = current_user.farms.as_json(only: [:name, :address], methods: [:id])
    render json: @response.success(response_data), status: :ok
  end

  def show
    response_data = @farm.as_json(
      methods: [:id],
      except: [:_id, :pictures, :created_at, :updated_at, :user_id],
      include: { device: { only: [:ip], methods: [:id] },
                 camera: { only: [:ip], methods: [:id, :port, :username, :password] } }
    )
    render json: @response.success(response_data), status: :ok
  end

  def sensor_data
    time = sensor_data_params[:time]
    type = sensor_data_params[:type]
    prop = sensor_data_params[:prop]

    unless prop.in?(%w(temperature humidity light soil_moisture))
      return render_invalid_params
    end

    time = Time.at(time.to_i/1000)

    if type.to_i == 0
      query_result = Value.avg_in_hour_of_date(
        device_id: @farm.device.id,
        year: time.year,
        month: time.month,
        day: time.day,
        prop: prop
      )
    else
      query_result = Value.avg_in_hour_of_month(
        device_id: @farm.device.id,
        year: time.year,
        month: time.month,
        prop: prop
      )
    end

    response_data = query_result.map do |record|
      {
        "time" => record[:_id][:hour],
        "#{prop}" => record[prop.to_sym].round(2)
      }
    end
    render json: @response.success(response_data), status: :ok
  end

  def pictures
    response_data = @farm.pictures.map do |picture|
      {
        created_at: picture.created_at.strftime('%Y-%m-%d %H:%M:%S'),
        url: request.base_url + picture.file.url
      }
    end
    render json: @response.success(response_data), status: :ok
  end

  def upload_picture
    begin
      picture = Picture.new(upload_picture_params)
      @farm.pictures.push(picture)

      if @farm.save
        render json: @response.success({message: 'Picture have been saved'}), status: :ok
      else
        render json: @response.failure({error: @farm.errors.full_messages.first}), status: :unprocessable_entity
      end
    rescue
      render_invalid_params
    ensure
      clean_tempfile
    end
  end

  private

  def set_farm
    @farm ||= current_user.farms.find(params[:id])
    render json: @response.failure({ error: 'Not found' }), status: :not_found unless @farm
  end

  def sensor_data_params
    params.permit(:time, :prop, :type)
  end

  def render_invalid_params
    render json: @response.failure(error: 'Invalid params'), status: :bad_request
  end

  def upload_picture_params
    ps = params.permit(:file)
    ps[:file] = parse_image_data(ps[:file]) if ps[:file]
    ps
  end
end
