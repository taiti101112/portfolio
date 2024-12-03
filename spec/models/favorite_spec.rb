require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let(:user) { create(:user) }
  let(:shop) { create(:shop) }

  it 'is valid with valid attributes' do
    favorite = Favorite.new(user: user, shop: shop)
    expect(favorite).to be_valid
  end

  it 'is invalid with duplicate user_id and shop_id' do
    Favorite.create(user: user, shop: shop)
    duplicate_favorite = Favorite.new(user: user, shop: shop)
    expect(duplicate_favorite).to_not be_valid
  end
end
