require 'rails_helper'

RSpec.describe "Devise Authentication", type: :request do
  let!(:user) { create(:user, password: "password") }

  describe "POST /users/sign_in" do
    it "logs in the user" do
      post user_session_path, params: { user: { email: user.email, password: "password" } }
      expect(response).to redirect_to(user_path(user))
    end
  end

  describe "DELETE /users/sign_out" do
    before do
      sign_in user
    end

    it "logs out the user" do
      delete destroy_user_session_path
      expect(response).to redirect_to(root_path)
    end
  end
end
