require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:shop) { create(:shop) }

  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end

  it 'is invalid without an email' do
    user.email = nil
    expect(user).to_not be_valid
  end

  it 'is invalid without a name' do
    user.name = nil
    expect(user).to_not be_valid
  end

  describe '#favorite?' do
    it 'returns true if the user has favorited the shop' do
      user.favorite(shop)
      expect(user.favorite?(shop)).to be true
    end

    it 'returns false if the user has not favorited the shop' do
      expect(user.favorite?(shop)).to be false
    end
  end
end
