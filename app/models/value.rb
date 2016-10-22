class Value
  include Mongoid::Document
  include Mongoid::Timestamps

  # fields
  field :temp, type: Float
  field :air_humid, type: Float
  field :soil_humid, type: Float
  field :brightness, type: Float

  # assocations
  belongs_to :device

  # validations
  validates :temp, presence: true
  validates :air_humid, presence: true
  validates :soil_humid, presence: true
  validates :brightness, presence: true
end
