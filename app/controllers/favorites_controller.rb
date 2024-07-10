class FavoritesController < ApplicationController
  def create
    @shop = Shop.find(params[:shop_id])
    current_user.favorite(@shop)
  end

  def destroy
    @shop = current_user.favorites.find(params[:id]).shop
    current_user.unfavorite(@shop)
  end
end

