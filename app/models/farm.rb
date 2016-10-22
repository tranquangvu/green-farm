class Farm
  include Mongoid::Document
  include Mongoid::Timestamps

  # fields
  field :name, type: String
  field :address, type: String
  field :max_limit_temp, type: Float
  field :min_limit_temp, type: Float
  field :max_limit_air_humid, type: Float
  field :min_limit_air_humid, type: Float
  field :max_limit_soil_humid, type: Float
  field :min_limit_soil_humid, type: Float
  field :max_limit_brightness, type: Float
  field :min_limit_brightness, type: Float

  # associations
  belongs_to :user
  has_one :camera
  has_one :device

  # validations
  validates :name, presence: true
  validates :address, presence: true
end
