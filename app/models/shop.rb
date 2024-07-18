class Shop < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }

  geocoded_by :address
  after_validation :geocode

  def self.ransackable_attributes(auth_object = nil)
    %w[name]
  end

  belongs_to :user
  has_many :favorites, dependent: :destroy

  acts_as_taggable

end
