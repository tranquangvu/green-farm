class Api::V1::FarmsController < Api::ApiController
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
    start_date = sensor_data_params[:start_date]
    end_date = sensor_data_params[:end_date]
    prop = sensor_data_params[:prop]

    begin
      Date.parse(start_date)
      Date.parse(end_date)
    rescue
      return render_invalid_params
    end

    unless prop.in?(%w(temperature humidity light soil_moisture))
      return render_invalid_params
    end

    response_data = @farm.values.where(
      :created_at.gte => "#{start_date} 00:00:00",
      :created_at.lte => "#{end_date} 23:59:59"
    ).as_json(
      only: [prop.to_sym],
      methods: [:time]
    )

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
    params.permit(:start_date, :end_date, :prop)
  end

  def render_invalid_params
    render json: @response.failure(error: 'Invalid params'), status: :bad_request
  end

  def upload_picture_params
    ps = params.permit(:file)
    ps[:file] = parse_image_data(ps[:file]) if ps[:file]
    ps
  end

  def parse_image_data(base64_image)
    filename = "upload_#{Time.now.to_i}"
    in_content_type, encoding, string = base64_image.split(/[:;,]/)[1..3]

    @tempfile = Tempfile.new(filename)
    @tempfile.binmode
    @tempfile.write Base64.decode64(string)
    @tempfile.rewind

    # for security we want the actual content type, not just what was passed in
    content_type = `file --mime -b #{@tempfile.path}`.split(";")[0]

    # we will also add the extension ourselves based on the above
    # if it's not gif/jpeg/png, it will fail the validation in the upload model
    extension = content_type.match(/gif|jpeg|png/).to_s
    filename += ".#{extension}" if extension

    ActionDispatch::Http::UploadedFile.new({
      tempfile: @tempfile,
      content_type: content_type,
      filename: filename
    })
  end

  def clean_tempfile
    if @tempfile
      @tempfile.close
      @tempfile.unlink
    end
  end
end
