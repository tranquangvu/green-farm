class Value
  include Mongoid::Document
  include Mongoid::Timestamps

  # fields
  field :temperature,   type: Float
  field :humidity,      type: Float
  field :soil_moisture, type: Float
  field :light,         type: Float

  # assocations
  belongs_to :device
  delegate :farm, to: :device

  # validations
  validates :temperature,
            presence: true,
            allow_nil: false,
            numericality: { less_than: 50 }
  validates :humidity,
            presence: true,
            allow_nil: false,
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :soil_moisture,
            presence: true,
            allow_nil: false,
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :light,
            presence: true,
            allow_nil: false,
            numericality: true

  # triggers
  after_save :add_notification_and_control_device

  def time
    created_at.strftime('%Y-%m-%d %H:%M:%S')
  end

  def self.to_csv(props)
    CSV.generate(headers: true) do |csv|
      csv << props.map do |prop|
        title = prop.to_s.humanize
        title << case prop
          when :temperature
            ' (celsius)'
          when :humidity, :soil_moisture
            ' (%)'
          when :light
            ' (lux)'
          else
            ''
        end
      end

      all.each do |record|
        csv << props.map { |prop| record.send(prop) }
      end
    end
  end

  def self.get_value_of_date(device_id:, year:, month:, day:, prop:)
    $project = {
      "$project" => {
        "year" => {
          "$year" => { "$add" => ["$created_at", 7 * 60 * 60 * 1000] }
        },
        "month" => {
          "$month" => { "$add" => ["$created_at", 7 * 60 * 60 * 1000] }
        },
        "day" => {
          "$dayOfMonth" => { "$add" => ["$created_at", 7 * 60 * 60 * 1000] }
        },
        "hour" => {
          "$hour" => { "$add" => ["$created_at", 7 * 60 * 60 * 1000] }
        },
        "minute" => {
          "$minute" => { "$add" => ["$created_at", 7 * 60 * 60 * 1000] }
        },
        "device_id" => "$device_id",
        "#{prop}" => "$#{prop}",
      }
    }

    $match = {
      "$match" => {
        "device_id" => device_id,
        "year" => year,
        "month" => month,
        "day" => day
      }
    }

    self.collection.aggregate([$project, $match])
  end

  def self.avg_in_hour_of_date(device_id:, year:, month:, day: , prop:)
    $project = {
      "$project" => {
        "year" => {
          "$year" => { "$add" => ["$created_at", 7 * 60 * 60 * 1000] }
        },
        "month" => {
          "$month" => { "$add" => ["$created_at", 7 * 60 * 60 * 1000] }
        },
        "day" => {
          "$dayOfMonth" => { "$add" => ["$created_at", 7 * 60 * 60 * 1000] }
        },
        "hour" => {
          "$hour" => { "$add" => ["$created_at", 7 * 60 * 60 * 1000] }
        },
        "device_id" => "$device_id",
        "#{prop}" => "$#{prop}",
      }
    }

    $match = {
      "$match" => {
        "device_id" => device_id,
        "year" => year,
        "month" => month,
        "day" => day
      }
    }

    $group = {
      "$group" => {
        "_id" => {
          "device_id" => "$device_id",
          "year" => "$year",
          "month" => "$month",
          "day" => "$day",
          "hour" => "$hour"
        },
        "#{prop}" => {
          "$avg" => "$#{prop}"
        }
      }
    }

    $sort = {
      "$sort" => {
        "_id" => 1
      }
    }

    self.collection.aggregate([$project, $match, $group, $sort])
  end

  def self.avg_in_hour_of_month(device_id:, year:, month:, prop:)
    $project = {
      "$project" => {
        "year" => {
          "$year" => { "$add" => ["$created_at", 7 * 60 * 60 * 1000] }
        },
        "month" => {
          "$month" => { "$add" => ["$created_at", 7 * 60 * 60 * 1000] }
        },
        "hour" => {
          "$hour" => { "$add" => ["$created_at", 7 * 60 * 60 * 1000] }
        },
        "device_id" => "$device_id",
        "#{prop}" => "$#{prop}",
      }
    }

    $match = {
      "$match" => {
        "device_id" => device_id,
        "year" => year,
        "month" => month
      }
    }

    $group = {
      "$group" => {
        "_id" => {
          "device_id" => "$device_id",
          "year" => "$year",
          "month" => "$month",
          "hour" => "$hour"
        },
        "#{prop}" => {
          "$avg" => "$#{prop}"
        }
      }
    }

    $sort = {
      "$sort" => {
        "_id" => 1
      }
    }

    self.collection.aggregate([$project, $match, $group, $sort])
  end

  def self.avg_in_minute_of_month(device_id:, year:, month:, prop:)
    $project = {
      "$project" => {
        "year" => {
          "$year" => { "$add" => ["$created_at", 7 * 60 * 60 * 1000] }
        },
        "month" => {
          "$month" => { "$add" => ["$created_at", 7 * 60 * 60 * 1000] }
        },
        "hour" => {
          "$hour" => { "$add" => ["$created_at", 7 * 60 * 60 * 1000] }
        },
        "minute" => {
          "$minute" => { "$add" => ["$created_at", 7 * 60 * 60 * 1000] }
        },
        "device_id" => "$device_id",
        "#{prop}" => "$#{prop}",
      }
    }

    $match = {
      "$match" => {
        "device_id" => device_id,
        "year" => year,
        "month" => month
      }
    }

    $group = {
      "$group" => {
        "_id" => {
          "device_id" => "$device_id",
          "year" => "$year",
          "month" => "$month",
          "hour" => "$hour",
          "minute" => "$minute",
        },
        "#{prop}" => {
          "$avg" => "$#{prop}"
        }
      }
    }

    $sort = {
      "$sort" => {
        "_id" => 1
      }
    }

    self.collection.aggregate([$project, $match, $group, $sort])
  end

  private

  def add_notification_and_control_device
    if farm.min_limit_temperature && temperature < farm.min_limit_temperature
      Notification.create(farm: farm, kind: 'notice', content: 'Temperature is too low.')
    end

    if farm.max_limit_temperature && temperature > farm.max_limit_temperature
      Notification.create(farm: farm, kind: 'notice', content: 'Temperature is too high.')
    end

    if farm.min_limit_humidity && humidity < farm.min_limit_humidity
      Notification.create(farm: farm, kind: 'notice', content: 'Humidity is too low.')
    end

    if farm.max_limit_humidity && humidity > farm.max_limit_humidity
      Notification.create(farm: farm, kind: 'notice', content: 'Humidity is too high.')
    end

    if farm.min_limit_light && light < farm.min_limit_light
      notification_content = 'Light is too low. '
      if farm.auto_control
        $redis.publish('task', {
          task: 'turn_on_led',
          data: {
            device: { id: device.id, ip: device.ip }
          }
        }.to_json)
        notification_content << "Led is auto on."
      end
      Notification.create(farm: farm, kind: 'notice', content: notification_content)
    end

    if farm.max_limit_light && light > farm.max_limit_light
      notification_content = 'Light is too high. '
      if farm.auto_control
        $redis.publish('task', {
          task: 'turn_off_led',
          data: {
            device: { id: device.id, ip: device.ip }
          }
        }.to_json)
        notification_content << "Led is auto off."
      end
      Notification.create(farm: farm, kind: 'notice', content: notification_content)
    end

    if farm.min_limit_soil_moisture && soil_moisture < farm.min_limit_soil_moisture
      notification_content = 'Soil moisture is too low. '
      if farm.auto_control
        $redis.publish('task', {
          task: 'turn_on_servo',
          data: {
            device: { id: device.id, ip: device.ip }
          }
        }.to_json)
        notification_content << "Servo is auto on."
      end
      Notification.create(farm: farm, kind: 'notice', content: notification_content)
    end

    if farm.max_limit_soil_moisture && soil_moisture > farm.max_limit_soil_moisture
      notification_content = 'Soil moisture is too high. '
      if farm.auto_control
        $redis.publish('task', {
          task: 'turn_off_servo',
          data: {
            device: { id: device.id, ip: device.ip }
          }
        }.to_json)
        notification_content << "Servo is auto off."
      end
      Notification.create(farm: farm, kind: 'notice', content: notification_content)
    end
  end
end
