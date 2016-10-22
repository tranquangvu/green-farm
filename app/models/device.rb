class Device
  include Mongoid::Document
  include Mongoid::Timestamps

  # fields
  field :ip, type: String

  # associations
  belongs_to :farm
  has_many :values, dependent: :destroy

  # validations
  validates :ip, presence: true
end
