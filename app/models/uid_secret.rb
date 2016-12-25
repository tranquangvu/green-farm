class UidSecret
  include Mongoid::Document
  include Mongoid::Timestamps

  # fields
  field :uid,     type: String
  field :secret,  type: String

  # validations
  validates :uid, presence: true
end
