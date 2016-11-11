class Inspecter::CamerasController < Inspecter::BaseController
  before_action :camera, only: [:show]

  def index
    @cameras = Camera.all
  end

  def show
  end

  private

  def camera
    @camera = Camera.find(params[:id])
  end
end
