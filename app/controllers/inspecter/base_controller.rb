class Inspecter::BaseController < ApplicationController
  layout 'inspecter'

  before_action :authenticate_user!
  before_action :set_farms
  before_action :set_farm, only: [:dashboard]

  def dashboard
    @last_value = @farm.values.last
    @start_date = Date.today.months_since(-1).at_beginning_of_month.strftime('%Y-%m-%d')
    @end_date   = Date.today.months_since(-1).end_of_month.strftime('%Y-%m-%d')
    @props      = [:temperature, :humidity, :light, :soil_moisture]
    @data       = @farm.values.where(:created_at.gte => "#{@start_date} 00:00:00",
                                     :created_at.lte => "#{@end_date} 23:59:59" )
  end

  private

  def set_farms
    @farms = current_user.farms
  end

  def set_farm
    @farm  = Farm.find(params[:id])
  end
end
