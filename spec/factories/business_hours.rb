# spec/factories/business_hours.rb
FactoryBot.define do
  factory :business_hour do
    shop
    day_of_week { 1 }
    opening_time { "09:00" }
    closing_time { "18:00" }
  end
end