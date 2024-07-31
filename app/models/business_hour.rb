class BusinessHour < ApplicationRecord
  belongs_to :shop

  validates :day_of_week, :opening_time, :closing_time, presence: true
end
