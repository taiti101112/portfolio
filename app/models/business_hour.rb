class BusinessHour < ApplicationRecord
  belongs_to :shop

  validates :day_of_week, presence: true
  validates :opening_time, presence: true
  validates :closing_time, presence: true
end
