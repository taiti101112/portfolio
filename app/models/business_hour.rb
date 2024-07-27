class BusinessHour < ApplicationRecord
  belongs_to :shop
  validates :day_of_week,inclusion: {in: 0..6 }
end
