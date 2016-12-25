class Contact
  include Mongoid::Document
  include Mongoid::Timestamps

  #fields
  field :email,         type: String
  field :first_name,    type: String
  field :last_name,     type: String
  field :phone_number,  type: String
  field :message,       type: String
  field :done,          type: Boolean, default: false

  # validations
  validates :email,
            presence: true,
            format: { with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/ }
  validates :first_name,
            presence: true,
            length: { minimum: 3, maximum: 20 }
  validates :last_name,
            presence: true,
            length: { minimum: 3, maximum: 20 }
  validates :phone_number,
            presence: true
end
