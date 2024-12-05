require 'rails_helper'

RSpec.describe "Admin::Shops API", type: :request do
  let!(:admin_user) { create(:user, admin: true) }
  let!(:shop) { create(:shop) }

  before do
    sign_in admin_user
  end

  describe "GET /admin/shops" do
    it "returns all shops for the admin" do
      get admin_shops_path
      expect(response).to have_http_status(:success)
    end
  end


end
