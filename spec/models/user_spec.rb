# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:shop) { create(:shop) }

  it 'userモデルにnameとemailが存在すること' do
    expect(user).to be_valid
  end

  it 'userモデルにemailが存在しない場合にバリデーションが働くこと' do
    user.email = nil
    expect(user).to_not be_valid
  end

  it 'userモデルにnameが存在しない場合にバリデーションが働くこと' do
    user.name = nil
    expect(user).to_not be_valid
  end

  describe 'お気に入り登録' do
    it '正しくお気に入り登録されること' do
      user.favorite(shop)
      expect(user.favorite?(shop)).to be true
    end

    it 'お気に入り登録されていないこと' do
      expect(user.favorite?(shop)).to be false
    end
  end
end
