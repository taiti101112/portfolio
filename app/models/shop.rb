class Shop < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }

  def self.ransackable_attributes(auth_object = nil)
    %w[name]
  end

  belongs_to :user
  has_many :favorites, dependent: :destroy

  acts_as_taggable

end
