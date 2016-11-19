class Inspecter::BaseController < ApplicationController
  layout 'inspecter'

  before_action :authenticate_user!
  before_action :set_farms

  def dashboard
    @farm = Farm.find(params[:farm_id])
  end

  private

  def set_farms
    @farms = Farm.all
  end
end
