class Value
  include Mongoid::Document
  include Mongoid::Timestamps

  # fields
  field :temperature, type: Float
  field :humidity, type: Float
  field :soil_moisture, type: Float
  field :light, type: Float

  # assocations
  belongs_to :device

  # validations
  validates :temperature, presence: true
  validates :humidity, presence: true
  validates :soil_moisture, presence: true
  validates :light, presence: true

  after_save :sent_notification

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
          "$year" => "$created_at"
        },
        "month" => {
          "$month" => "$created_at"
        },
        "day" => {
          "$dayOfMonth" => "$created_at"
        },
        "hour" => {
          "$hour" => "$created_at"
        },
        "minute" => {
          "$minute" => "$created_at"
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
          "$year" => "$created_at"
        },
        "month" => {
          "$month" => "$created_at"
        },
        "day" => {
          "$dayOfMonth" => "$created_at"
        },
        "hour" => {
          "$hour" => "$created_at"
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
          "$year" => "$created_at"
        },
        "month" => {
          "$month" => "$created_at"
        },
        "hour" => {
          "$hour" => "$created_at"
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
          "$year" => "$created_at"
        },
        "month" => {
          "$month" => "$created_at"
        },
        "hour" => {
          "$hour" => "$created_at"
        },
        "minute" => {
          "$minute" => "$created_at"
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

  def sent_notification
    farm = device.farm

    if temperature < farm.min_limit_temperature
      Notification.create(farm: farm, kind: 'notice', content: 'Temperature is too low.')
    end

    if temperature > farm.max_limit_temperature
      Notification.create(farm: farm, kind: 'notice', content: 'Temperature is too high.')
    end

    if humidity < farm.min_limit_humidity
      Notification.create(farm: farm, kind: 'notice', content: 'Humidity is too low.')
    end

    if humidity > farm.max_limit_humidity
      Notification.create(farm: farm, kind: 'notice', content: 'Humidity is too high.')
    end

    if light < farm.min_limit_light
      Notification.create(farm: farm, kind: 'notice', content: 'Light is too low.')
    end

    if light > farm.max_limit_light
      Notification.create(farm: farm, kind: 'notice', content: 'Light is too high.')
    end

    if soil_moisture < farm.min_limit_soil_moisture
      Notification.create(farm: farm, kind: 'notice', content: 'Soil moisture is too low.')
    end

    if soil_moisture > farm.max_limit_soil_moisture
      Notification.create(farm: farm, kind: 'notice', content: 'Soil moisture is too high.')
    end
  end
end
