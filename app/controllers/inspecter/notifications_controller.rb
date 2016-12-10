class Inspecter::NotificationsController < Inspecter::BaseController
  before_action :set_farm
  before_action :set_notification, only: [:seen]

  def index
    @notifications = @farm.notifications.page(params[:page])
  end

  def seen
    @notification.update(seen: true)
    @notifications = @farm.notifications.page(params[:page])
  end

  def mark_all_seen
    @farm.notifications.update_all(seen: true)
    @notifications = @farm.notifications.page(params[:page])
  end

  private

  def set_farm
    @farm = Farm.find(params[:farm_id])
  end

  def set_notification
    @notification = Notification.find(params[:id])
  end
end
