require 'rails_helper'

RSpec.describe "Favorites API", type: :request do
  let!(:user) { create(:user) }
  let!(:shop) { create(:shop) }

  before do
    sign_in user
  end

  describe "POST /favorites" do
    it "creates a favorite for the shop" do
      expect {
        post favorites_path, params: { shop_id: shop.id }, headers: { "ACCEPT" => "application/json" }
      }.to change(Favorite, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(response.body).to include_json(success: true)
    end
  end

  describe "DELETE /favorites/:id" do
    let!(:favorite) { create(:favorite, user: user, shop: shop) }

    it "deletes the favorite" do
      expect {
        delete favorite_path(favorite), headers: { "ACCEPT" => "application/json" }
      }.to change(Favorite, :count).by(-1)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include_json(success: true)
    end
  end
end
