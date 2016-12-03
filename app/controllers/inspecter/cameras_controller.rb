class Inspecter::CamerasController < Inspecter::BaseController
  before_action :set_camera
  before_action :set_farm

  def show
  end

  private

  def set_camera
    @camera = Camera.find(params[:id])
  end

  def set_farm
    @farm = Farm.find(params[:farm_id])
  end
end
