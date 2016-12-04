class Inspecter::FarmsController < Inspecter::BaseController
  before_action :set_farm, except: [:index]

  def index
    @farms = current_user.farms
  end

  def show
  end

  def report
    @start_date = report_params[:start_date] || current_date
    @end_date = report_params[:end_date] || current_date
    @props = (report_params[:props] || all_query_props).map(&:to_sym)

    @data = @farm.values.where(
      :created_at.gte => "#{@start_date} 00:00:00",
      :created_at.lte => "#{@end_date} 23:59:59"
    ).only(*@props, :created_at)

    respond_to do |format|
      filename = "#{@farm.name}_data_#{@start_date}_#{@end_date}"

      format.html
      format.csv  { send_data @data.to_csv(@props.unshift(:time)), filename: "#{filename}.csv" }
      format.xlsx { render xlsx: 'report', filename: "#{filename}.xlsx" }
    end
  end

  def chart
  end

  def settings
  end

  def gallery
  end

  def update
    if @farm.update(farm_params)
      redirect_to inspecter_dashboard_path, notice: 'Updated settings successfully'
    else
      render :settings
    end
  end

  private

  def set_farm
    @farm = Farm.find(params[:id])
  end

  def all_query_props
    %w(temperature humidity light soil_moisture)
  end

  def current_date
    Time.now.strftime('%Y-%m-%d')
  end

  def report_params
    params.permit(:start_date, :end_date, props: [])
  end

  def farm_params
    params.require(:farm).permit(:name, :address,
      :max_limit_temperature, :min_limit_temperature, :max_limit_humidity, :min_limit_humidity,
        :max_limit_soil_moisture, :min_limit_soil_moisture, :max_limit_light, :min_limit_light)
  end
end
