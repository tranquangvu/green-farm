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
end
