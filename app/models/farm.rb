class Farm
  include Mongoid::Document
  include Mongoid::Timestamps

  # fields
  field :name
  field :address

  # associations
  embedded_in :user
  embeds_many :cameras

  # validations
  validates :name, presence: true
  validates :address, presence: true
end
