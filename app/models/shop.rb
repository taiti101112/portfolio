class Shop < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }

  geocoded_by :address
  after_validation :geocode

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :business_hours, dependent: :destroy

  acts_as_taggable

  def self.ransackable_attributes(auth_object = nil)
    %w[name]
  end

  def open_now?
    current_time = Time.zone.now
    current_day = current_time.wday
    business_hour = business_hours.find_by(day_of_week: current_day)
  
    return false unless business_hour
  
    opening_time = business_hour.opening_time
    closing_time = business_hour.closing_time
    current_time.strftime("%H:%M") >= opening_time.strftime("%H:%M") && current_time.strftime("%H:%M") <= closing_time.strftime("%H:%M")
  end



end
