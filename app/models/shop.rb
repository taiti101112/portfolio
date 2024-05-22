class Shop < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }

  def self.ransackable_attributes(auth_object = nil)
    %w[name]
  end

end
