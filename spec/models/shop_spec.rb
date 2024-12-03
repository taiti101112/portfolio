require 'rails_helper'

RSpec.describe Shop, type: :model do
  let(:user) { create(:user) }
  let(:shop) { create(:shop, user: user) }

  it 'is valid with valid attributes' do
    expect(shop).to be_valid
  end

  it 'is invalid without a name' do
    shop.name = nil
    expect(shop).to_not be_valid
  end

  it 'is invalid with a duplicate name' do
    Shop.create(name: 'Test Shop', user: user)
    duplicate_shop = Shop.new(name: 'Test Shop', user: user)
    expect(duplicate_shop).to_not be_valid
  end

  describe '#open_now?' do
    it 'returns true if the shop is open now' do
      create(:business_hour, shop: shop, day_of_week: Time.zone.now.wday,
             opening_time: 1.hour.ago, closing_time: 1.hour.from_now)
      expect(shop.open_now?).to be true
    end

    it 'returns false if the shop is closed now' do
      create(:business_hour, shop: shop, day_of_week: Time.zone.now.wday,
             opening_time: 2.hours.ago, closing_time: 1.hour.ago)
      expect(shop.open_now?).to be false
    end
  end
end
