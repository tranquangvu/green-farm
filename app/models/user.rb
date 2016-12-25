class User
  include Mongoid::Document

  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :username,           type: String, default: ""
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""
  field :uid,                type: String, default: ""
  field :admin,              type: Boolean, default: false

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  mount_uploader :avatar, AvatarUploader

  # asssocations
  has_many :farms, dependent: :destroy

  # triggers
  before_create :set_authenticatable

  # validations
  validates :username, presence: true, length: { minimum: 3, maximum: 15 }

  def current_admin
    current_user && current_user.admin?
  end

  private

  def set_authenticatable
    self.uid = SecureRandom.uuid
    UidSecret.create(uid: self.uid, secret: SecureRandom.hex(64))
  end
end
