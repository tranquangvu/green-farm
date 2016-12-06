class Notification
  include Mongoid::Document
  include Mongoid::Timestamps

  # fields
  field :content, type: String
  field :kind, type: String

  # associations
  belongs_to :farm

  # validations
  validates :content, presence: true
  validates :kind, presence: true
end
