module Admin
  class ShopsController < ApplicationController
    # before_action :authenticate_admin! # 管理者認証を有効にする場合

    def index
      @shops = Shop.all
    end

    def show
      @shop = Shop.find(params[:id])
      @tags = @shop.tag_counts_on(:tags)
    end

    def new
      @shop = Shop.new
    end

    def edit
      @shop = Shop.find(params[:id])
    end

    def create
      @shop = Shop.new(shop_params)
      if @shop.save
        redirect_to [:admin, @shop], notice: 'ショップの作成が完了しました'
      else
        render :new
      end
    end

    def update
      @shop = Shop.find(params[:id])
      if @shop.update(shop_params)
        redirect_to [:admin, @shop], notice: 'ショップの更新が完了しました'
      else
        render :edit
      end
    end

    def destroy
      @shop = Shop.find(params[:id])
      @shop.destroy
      redirect_to admin_shops_url, notice: 'ショップの削除が完了しました'
    end

    private

    def shop_params
      params.require(:shop).permit(:name, :address, :phone_number, :duel_space_available, :opening_hours, :tag_list,)
    end
  end
end