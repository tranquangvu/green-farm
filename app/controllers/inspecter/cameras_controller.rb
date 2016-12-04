class Inspecter::CamerasController < Inspecter::BaseController
  before_action :set_camera
  before_action :set_farm

  def show
    @video_stream = @camera.video_stream_url
  end

  def snapshot
    response = HTTParty.get(@camera.snapshot_url)
    extension = response.headers["content-disposition"].match(/gif|jpeg|png|jpg/).to_s
    filename = "snapshot_#{@farm.id}_#{Time.now.to_i}.#{extension}"
    content_type = response.headers["content-type"]

    if params[:save_to_gallery] == 'true'
      begin
        file = parse_image_data(filename: filename,
                                content_type: content_type,
                                content: response.parsed_response)
        picture = Picture.new(file: file)
        @farm.pictures.push(picture)
        @farm.save!
      ensure
        clean_tempfile
      end
      redirect_to :back, notice: 'Your snapshot have been saved'
    else
      send_data response.parsed_response, content_type: content_type, filename: filename
    end
  end

  private

  def set_camera
    @camera = Camera.find(params[:id])
  end

  def set_farm
    @farm = Farm.find(params[:farm_id])
  end

  def parse_image_data(filename:, content_type:, content:)
    @tempfile = Tempfile.new(filename)
    @tempfile.binmode
    @tempfile.write(content)
    @tempfile.rewind

    ActionDispatch::Http::UploadedFile.new({
      tempfile: @tempfile,
      type: content_type,
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
