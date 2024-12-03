require 'rails_helper'

RSpec.describe BusinessHour, type: :model do
  let(:shop) { create(:shop) }

  it 'is valid with valid attributes' do
    business_hour = BusinessHour.new(
      shop: shop,
      day_of_week: 1,
      opening_time: Time.zone.parse('09:00'),
      closing_time: Time.zone.parse('18:00')
    )
    expect(business_hour).to be_valid
  end

  it 'is invalid without a day_of_week' do
    business_hour = BusinessHour.new(shop: shop, opening_time: '09:00', closing_time: '18:00')
    business_hour.day_of_week = nil
    expect(business_hour).to_not be_valid
  end

  it 'is invalid without an opening_time' do
    business_hour = BusinessHour.new(shop: shop, day_of_week: 1, closing_time: '18:00')
    business_hour.opening_time = nil
    expect(business_hour).to_not be_valid
  end

  it 'is invalid without a closing_time' do
    business_hour = BusinessHour.new(shop: shop, day_of_week: 1, opening_time: '09:00')
    business_hour.closing_time = nil
    expect(business_hour).to_not be_valid
  end
end
