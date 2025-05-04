require 'rails_helper'

RSpec.describe 'プライバシーポリシー', type: :request do
  describe 'GET /privacy_policy' do
    it 'プライバシーポリシー画面に遷移すること' do
      get privacy_policy_path
      expect(response).to have_http_status(:success)
    end
  end

  describe '利用規約' do
    it '利用規約ページに遷移すること' do
      get terms_of_service_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'お問い合わせ' do
    it 'お問い合わせページから問い合わせができること' do
      post contact_path, params: { name: 'Test User', email: 'test@example.com', message: 'Hello!' }
      expect(response).to redirect_to(contact_path)
      follow_redirect!
      expect(response.body).to include('お問合せありがとうございました')
    end
  end
end
