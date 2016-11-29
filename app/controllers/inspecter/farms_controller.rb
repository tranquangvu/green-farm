class Inspecter::FarmsController < Inspecter::BaseController
  before_action :set_farm, only: [:show, :report, :chart]

  def index
    @farms = current_user.farms
  end

  def show
  end

  def report
    @start_date = report_params[:start_time] || current_date
    @end_date = report_params[:end_date] || current_date
    @props = report_params[:props].map(&:to_sym) || all_query_props

    @data = @farm.values.where(
      :created_at.gte => "#{@start_date} 00:00:00",
      :created_at.lte => "#{@end_date} 23:59:59"
    ).only(*@props, :created_at)
  end

  def chart
  end

  private

  def set_farm
    @farm = Farm.find(params[:id])
  end

  def all_query_props
    [:temperature, :humidity, :light, :soil_moisture]
  end

  def current_date
    Time.now.strftime('%Y-%m-%d')
  end

  def report_params
    params.permit(:start_date, :end_date, props: [])
  end
end
