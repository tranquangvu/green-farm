class Farm < ApplicationRecord
  belongs_to :user
  has_many :cameras

  validates :address, presence: true
  validates :section_index, presence: true
end
