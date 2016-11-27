class Inspecter::FarmsController < Inspecter::BaseController
  before_action :set_farm, only: [:show, :report, :chart]

  def index
    @farms = current_user.farms
  end

  def show
  end

  def report
  end

  def chart
  end

  private

  def set_farm
    @farm = Farm.find(params[:id])
  end
end
