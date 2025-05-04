# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ショップ機能', type: :request do
  let!(:user) { create(:user) }
  let!(:shop) { create(:shop, user: user) }
  let!(:business_hour) do
    create(:business_hour, shop: shop, day_of_week: Time.zone.now.wday, opening_time: '09:00', closing_time: '18:00')
  end

  describe 'ショップ一覧' do
    it 'ショップ一覧ページに正しく遷移すること' do
      get shops_path
      expect(response).to have_http_status(:success)
      expect(assigns(:shops)).to include(shop)
    end
  end

  describe 'ショップ詳細' do
    it 'ショップ詳細ページに正しく遷移すること' do
      get shop_path(shop)
      expect(response).to have_http_status(:success)
      expect(assigns(:shop)).to eq(shop)
    end
  end

  describe 'マップ検索' do
    it 'マップ検索ページに正しく遷移すること' do
      get map_shops_path
      expect(response).to have_http_status(:success)
      expect(assigns(:shops)).to include(shop)
    end
  end
end
