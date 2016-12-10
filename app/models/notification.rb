class Notification
  include Mongoid::Document
  include Mongoid::Timestamps

  # fields
  field :content, type: String
  field :kind, type: String
  field :seen, type: Boolean, default: false

  # associations
  belongs_to :farm

  # validations
  validates :content, presence: true
  validates :kind, presence: true

  paginates_per 25

  def self.not_seen
    where(seen: false)
  end
end
