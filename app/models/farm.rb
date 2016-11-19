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

  # associations
  belongs_to :user
  has_one :camera
  has_one :device

  # validations
  validates :name, presence: true
  validates :address, presence: true
end
