module ApplicationHelper
  def alert_class_by_name(name)
    alerts[name.to_sym] || name.to_s
  end

  def alerts
    { success: 'alert-success', error: 'alert-danger', alert: 'alert-warning', notice: 'alert-info' }
  end
end
