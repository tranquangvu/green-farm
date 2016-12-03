class Inspecter::NotificationsController < Inspecter::BaseController
  before_action :set_farm

  def index
  end

  private

  def set_farm
    @farm = Farm.find(params[:farm_id])
  end
end
