class BusinessHour < ApplicationRecord
  validates :day_of_week, presence: true
  validates :opening_time, presence: true
  validates :closing_time, presence: true
  belongs_to :shop
end
