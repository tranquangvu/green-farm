class Inspecter::FarmsController < Inspecter::BaseController
  before_action :farm, only: [:show]

  def index
    @farms = current_user.farms
  end

  def show
    @cameras = farm.cameras
  end

  private

  def farm
    @farm = Farm.find(params[:id])
  end
end
