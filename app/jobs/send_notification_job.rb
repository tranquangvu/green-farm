require 'gcm'

class SendNotificationJob < ApplicationJob
  def perform(notification)
    gcm = GCM.new(api_key)

    response = gcm.send_to_topic(
      notification.farm.id.to_s, {
        data: { message: notification.content }
      }
    )
  end

  private

  def api_key
    Rails.application.secrets.gcm_api_key
  end
end
