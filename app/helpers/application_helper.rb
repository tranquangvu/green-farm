module ApplicationHelper
  def get_alert_class(name)
    types = { notice: 'alert-info', error: 'alert-danger',
              success: 'alert-success', alert: 'alert-warning' }
    types[name.to_sym] || name.to_s
  end

  def show_date(date)
    date.strftime('%Y-%m-%d %H:%M')
  end

  def show_temperature(temp)
    raw "#{temp.round(2).to_s} &#8451"
  end

  def show_humid(humid)
    "#{humid} %"
  end

  def show_light(light)
    "#{light} lux"
  end

  def show_value_by_prop(value, prop)
    case prop
    when :temperature
      show_temperature(value[prop])
    when :humidity, :soil_moisture
      show_humid(value[prop])
    else
      show_light(value[prop])
    end
  end

  def color_by_prop(prop)
    case prop
      when :temperature
        'warning'
      when :humidity
        'info'
      when :light
        'danger'
      else
        'success'
    end
  end
end
