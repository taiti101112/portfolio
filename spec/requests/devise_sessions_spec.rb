# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Devise認証', type: :request do
  let!(:user) do
    create(:user, name: 'test_user', email: 'test@example.com', password: 'password', password_confirmation: 'password')
  end

  describe 'ログイン' do
    it 'ログインできること' do
      post user_session_path, params: { user: { email: user.email, name: user.name, password: 'password' } }
      expect(response).to redirect_to(user_path(user))
    end
  end

  describe 'ログアウト' do
    before do
      sign_in user
    end

    it 'ログアウトできること' do
      delete destroy_user_session_path
      expect(response).to redirect_to(root_path)
    end
  end
end
