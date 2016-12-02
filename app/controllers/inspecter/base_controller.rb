class Inspecter::BaseController < ApplicationController
  layout 'inspecter'

  before_action :authenticate_user!
  before_action :set_data

  def dashboard
    @last_value = @farm.values.last
    @start_date = Date.today.at_beginning_of_month.strftime('%Y-%m-%d')
    @end_date   = Date.today.end_of_month.strftime('%Y-%m-%d')
    @data       = @farm.values.where(:created_at.gte => "#{@start_date} 00:00:00",
                                     :created_at.lte => "#{@end_date} 23:59:59" )
  end

  private

  def set_data
    @farm  = Farm.find(params[:farm_id])
    @farms = current_user.farms
  end
end
