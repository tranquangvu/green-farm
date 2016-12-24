class Farm
  include Mongoid::Document
  include Mongoid::Timestamps

  # fields
  field :name, type: String
  field :address, type: String
  field :max_limit_temperature, type: Float
  field :min_limit_temperature, type: Float
  field :max_limit_humidity, type: Float
  field :min_limit_humidity, type: Float
  field :max_limit_soil_moisture, type: Float
  field :min_limit_soil_moisture, type: Float
  field :max_limit_light, type: Float
  field :min_limit_light, type: Float

  embeds_many :pictures, cascade_callbacks: true

  # associations
  belongs_to :user
  has_one :camera, dependent: :destroy
  has_one :device, dependent: :destroy
  has_many :notifications, dependent: :destroy

  delegate :values, to: :device

  # validations
  validates :name,
            presence: true
  validates :address,
            presence: true
  validates :max_limit_temperature,
            allow_nil: true,
            numericality: { less_than: 50 }
  validates :min_limit_temperature,
            allow_nil: true,
            numericality: { less_than: 50 }
  validates :max_limit_humidity,
            allow_nil: true,
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :min_limit_humidity,
            allow_nil: true,
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :max_limit_soil_moisture,
            allow_nil: true,
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :min_limit_soil_moisture,
            allow_nil: true,
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
end
