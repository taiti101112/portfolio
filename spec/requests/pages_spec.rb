require 'rails_helper'

RSpec.describe 'Pages API', type: :request do
  describe 'GET /privacy_policy' do
    it 'returns the privacy policy page' do
      get privacy_policy_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /terms_of_service' do
    it 'returns the terms of service page' do
      get terms_of_service_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /contact' do
    it 'sends a contact message' do
      post contact_path, params: { name: 'Test User', email: 'test@example.com', message: 'Hello!' }
      expect(response).to redirect_to(contact_path)
      follow_redirect!
      expect(response.body).to include('お問合せありがとうございました')
    end
  end
end
