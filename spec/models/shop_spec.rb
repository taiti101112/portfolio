require 'rails_helper'

RSpec.describe Shop, type: :model do
  let(:user) { create(:user) }
  let(:shop) { create(:shop, user: user) }

  it 'ショップモデルにnameが存在すること' do
    expect(shop).to be_valid
  end

  it 'ショップモデルにnameが存在しない場合にバリデーションが働くこと' do
    shop.name = nil
    expect(shop).to_not be_valid
  end

  it '同じ名前のショップ名を登録することができないこと' do
    Shop.create(name: 'Test Shop', user: user)
    duplicate_shop = Shop.new(name: 'Test Shop', user: user)
    expect(duplicate_shop).to_not be_valid
  end

  describe '営業中判定' do
    it '営業中だと正しく判定されること' do
      create(:business_hour, shop: shop, day_of_week: Time.zone.now.wday,
                             opening_time: 1.hour.ago, closing_time: 1.hour.from_now)
      expect(shop.open_now?).to be true
    end

    it '営業中でないと正しく判定されること' do
      create(:business_hour, shop: shop, day_of_week: Time.zone.now.wday,
                             opening_time: 2.hours.ago, closing_time: 1.hour.ago)
      expect(shop.open_now?).to be false
    end
  end
end
