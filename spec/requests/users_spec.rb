require 'rails_helper'

RSpec.describe "Users API", type: :request do
  let!(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "GET /users/:id" do
    it "returns the current user's details" do
      get user_path(user)
      expect(response).to have_http_status(:success)
      expect(assigns(:user)).to eq(user)
    end
  end
end
