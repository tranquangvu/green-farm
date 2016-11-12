class Inspecter::FarmsController < Inspecter::BaseController
  before_action :farm, only: [:show]

  def index
    @farms = current_user.farms
  end

  def show
    @camera = farm.camera
    @device = farm.device
  end

  private

  def farm
    @farm = Farm.find(params[:id])
  end
end
