class Shop < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :business_hours, dependent: :destroy
  accepts_nested_attributes_for :business_hours, allow_destroy: true

  # addressから住所を取得する設定
  geocoded_by :address
  after_validation :geocode

  # タグ機能を追加
  acts_as_taggable

  # ransackで利用可能な属性を指定
  def self.ransackable_attributes(auth_object = nil)
    %w[name]
  end

  # 営業中かどうかを判定する
  def open_now?
    # 現在時刻・曜日・営業時間を取得
    current_time = Time.zone.now
    current_day = current_time.wday
    business_hour = business_hours.find_by(day_of_week: current_day)
  
    # 営業時間がない場合はfalseを返す
    return false unless business_hour
  
    # 開店時間と閉店時間を取得
    opening_time = business_hour.opening_time
    closing_time = business_hour.closing_time
  
    # それぞれが0時から経過した秒数を取得
    current_time_seconds = current_time.seconds_since_midnight
    opening_time_seconds = opening_time.seconds_since_midnight
    closing_time_seconds = closing_time.seconds_since_midnight
  
    # 現在時刻が開店時間以上かつ閉店時間以下の時にtrue(営業中)を返す
    current_time_seconds >= opening_time_seconds && current_time_seconds <= closing_time_seconds
  end

  # 営業中のショップを取得
  scope :open_now, -> {
    current_time_seconds = Time.zone.now.seconds_since_midnight
    current_day = Time.zone.now.wday
  
    joins(:business_hours).where(
      'business_hours.day_of_week = ? AND EXTRACT(EPOCH FROM business_hours.opening_time) <= ? AND EXTRACT(EPOCH FROM business_hours.closing_time) >= ?',
      current_day,
      current_time_seconds,
      current_time_seconds
    ).distinct
  }

end
