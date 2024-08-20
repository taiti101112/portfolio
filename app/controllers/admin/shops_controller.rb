# app/controllers/admin/shops_controller.rb
module Admin
  class ShopsController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_shop, only: [:show, :edit, :update, :destroy, :edit_hours, :update_hours]
    before_action :set_tags
    before_action :set_is_admin

    def index
      @q = Shop.ransack(params[:q])
      if params[:q].present?
        @shops = @q.result(distinct: true)
      else
        @shops = Shop.all
      end

      if params[:tag_name]
        @shops = @shops.tagged_with(params[:tag_name])
      end
    end

    def show
      @tags = @shop.tag_counts_on(:tags)
    end

    def new
      @shop = Shop.new
      (1..7).each do |day|
        @shop.business_hours.build(day_of_week: day)
      end
    end
    
    def edit

    end

    def create
      @shop = Shop.new(shop_params)
      @shop.user = current_user
      if @shop.save
        redirect_to [@shop], notice: 'Shop and business hours were successfully created.'
      else
        render :new
      end
    end

    def update
      if @shop.update(shop_params)
        redirect_to [@shop], notice: 'ショップの更新が完了しました'
      else
        render :edit
      end
    end

    def destroy
      @shop.destroy
      redirect_to shops_url, notice: 'ショップの削除が完了しました'
    end

    private

    def set_shop
      @shop = Shop.find(params[:id])
    end

    def set_tags
      # Shopモデルに設定された全てのタグを取得
      @tags = ActsAsTaggableOn::Tag.for_context(:tags).most_used
    end

    def shop_params
      params.require(:shop).permit(
        :name, :address, :phone_number, :duel_space_available, :opening_hours, :official_hp, :twitter, :instagram, :tag_list,
        business_hours_attributes: [:id, :day_of_week, :opening_time, :closing_time, :_destroy]
      )
    end

    def set_is_admin
      @is_admin = current_user&.admin?
    end
  end
end
