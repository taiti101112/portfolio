class FavoritesController < ApplicationController
  def create
    @shop = Shop.find(params[:shop_id])
    current_user.favorite(@shop)

    respond_to do |format|
      format.html { redirect_to shop_path(@shop), notice: "お気に入りに追加しました。" }
      format.json { render json: { success: true, favorite_id: @shop.id }, status: :created }
    end
  end

  def destroy
    @shop = current_user.favorites.find(params[:id]).shop
    current_user.unfavorite(@shop)

    respond_to do |format|
      format.html { redirect_to shop_path(@shop), notice: "お気に入りを削除しました。" }
      format.json { render json: { success: true }, status: :ok }
    end
  end
end
