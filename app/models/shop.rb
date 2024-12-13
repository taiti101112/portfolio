class Shop < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }

  geocoded_by :address
  after_validation :geocode

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :business_hours, dependent: :destroy
  accepts_nested_attributes_for :business_hours, allow_destroy: true

  acts_as_taggable

  scope :near, ->(latitude, longitude) {
    select("#{table_name}.*, " \
           "(6371 * acos(cos(radians(#{latitude})) * cos(radians(latitude)) * " \
           "cos(radians(longitude) - radians(#{longitude})) + " \
           "sin(radians(#{latitude})) * sin(radians(latitude)))) AS distance")
      .order("distance ASC")
  }

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
    # Timeオブジェクトとして時間部分のみを比較
    current_time_seconds = current_time.seconds_since_midnight
    opening_time_seconds = opening_time.seconds_since_midnight
    closing_time_seconds = closing_time.seconds_since_midnight
  
    current_time_seconds >= opening_time_seconds && current_time_seconds <= closing_time_seconds
  end

  scope :open_now, -> {
    current_time = Time.zone.now
    joins(:business_hours).where('business_hours.opening_time <= ? AND business_hours.closing_time >= ?', current_time, current_time )
  }
  
end
