class FavoritesController < ApplicationController
  def create
    shop = Shop.find(params[:shop_id])
    current_user.favorite(shop)
    redirect_to shops_path
  end

  def destroy
    shop = current_user.favorites.find(params[:id]).shop
    current_user.unfavorite(shop)
    redirect_to shops_path, status: :see_other
  end
end

