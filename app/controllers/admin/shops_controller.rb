module Admin
  class ShopsController < ApplicationController
    before_action :authenticate_admin! # 管理者認証を有効にする

    def index
      @q = Shop.ransack(params[:q])
      @is_admin = current_user.admin?
      if params[:q].present?
        @shops = @q.result(distinct: true)
      else
        @shops = Shop.all
      end
    
      # タグで絞り込む
      if params[:tag_name]
        @shops = @shops.tagged_with(params[:tag_name])
      end
    end

    def show
      @is_admin = current_user.admin?
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
      @shop.user_id = current_user.id
      if @shop.save
        redirect_to [:admin, @shop], notice: 'ショップの作成が完了しました'
      else
        Rails.logger.error(@shop.errors.full_messages)
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
      params.require(:shop).permit(:name, :address, :phone_number, :duel_space_available, :opening_hours, :tag_list, :latitude, :longitude, :user_id)
    end
    

  end
end