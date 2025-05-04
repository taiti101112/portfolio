require 'rails_helper'

RSpec.describe 'お気に入り機能', type: :request do
  let!(:user) { create(:user) }
  let!(:shop) { create(:shop) }

  before do
    sign_in user
  end

  describe 'お気に入り登録' do
    it 'お気に入り登録できること' do
      expect do
        post favorites_path, params: { shop_id: shop.id }, headers: { 'ACCEPT' => 'application/json' }
      end.to change(Favorite, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(response.body).to include_json(success: true)
    end
  end

  describe 'お気に入り削除' do
    let!(:favorite) { create(:favorite, user: user, shop: shop) }

    it 'お気に入り登録を解除できること' do
      expect do
        delete favorite_path(favorite), headers: { 'ACCEPT' => 'application/json' }
      end.to change(Favorite, :count).by(-1)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include_json(success: true)
    end
  end
end
