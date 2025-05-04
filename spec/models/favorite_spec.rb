require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let(:user) { create(:user) }
  let(:shop) { create(:shop) }

  it 'favoriteモデルが正しく作成されること' do
    favorite = Favorite.new(user: user, shop: shop)
    expect(favorite).to be_valid
  end

  it '重複するデータではfavoriteモデルを作成できないこと' do
    Favorite.create(user: user, shop: shop)
    duplicate_favorite = Favorite.new(user: user, shop: shop)
    expect(duplicate_favorite).to_not be_valid
  end
end
