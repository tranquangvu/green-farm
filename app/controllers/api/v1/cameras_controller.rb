class Api::V1::CamerasController < Api::ApiController
  before_action :set_camera

  def up
    HTTParty.get(@camera.up_url)
    sleep(0.5)
    HTTParty.get(@camera.stop_up_url)
    render json: @response.success, status: :ok
  end

  def down
    HTTParty.get(@camera.down_url)
    sleep(0.5)
    HTTParty.get(@camera.stop_down_url)
    render json: @response.success, status: :ok
  end

  def left
    HTTParty.get(@camera.left_url)
    sleep(0.5)
    HTTParty.get(@camera.stop_left_url)
    render json: @response.success, status: :ok
  end

  def right
    HTTParty.get(@camera.right_url)
    sleep(0.5)
    HTTParty.get(@camera.stop_right_url)
    render json: @response.success, status: :ok
  end

  private

  def set_camera
    @camera = Camera.find(params[:id])
  end
end
