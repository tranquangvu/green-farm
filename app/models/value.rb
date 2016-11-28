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

  def time
    created_at
  end

  def self.get_value_of_date(device_id:, year:, month:, day:, prop: )
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
end
