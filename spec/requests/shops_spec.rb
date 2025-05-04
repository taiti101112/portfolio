require 'rails_helper'

RSpec.describe 'ショップ機能', type: :request do
  let!(:user) { create(:user) }
  let!(:shop) { create(:shop, user: user) }
  let!(:business_hour) do
    create(:business_hour, shop: shop, day_of_week: Time.zone.now.wday, opening_time: '09:00', closing_time: '18:00')
  end

  describe 'GET /shops' do
    it 'returns all shops' do
      get shops_path
      expect(response).to have_http_status(:success)
      expect(assigns(:shops)).to include(shop)
    end
  end

  describe 'GET /shops/:id' do
    it 'returns the specified shop' do
      get shop_path(shop)
      expect(response).to have_http_status(:success)
      expect(assigns(:shop)).to eq(shop)
    end
  end

  describe 'GET /shops/map' do
    it 'returns shops on the map' do
      get map_shops_path
      expect(response).to have_http_status(:success)
      expect(assigns(:shops)).to include(shop)
    end
  end
end
