module Admin
  class ShopsController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_shop, only: [:show, :edit, :update, :destroy, :edit_hours, :update_hours]
    before_action :set_tags
    before_action :set_is_admin

    def index
    end

    def show
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
        redirect_to [@shop], notice: t('flash.actions.shop.create.success')
      else
        flash.now[:alert] = t('flash.actions.shop.create.failure')  # flash.now[:error] から flash.now[:alert] に修正
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @shop.update(shop_params)
        redirect_to [@shop], notice: t('flash.actions.shop.update.success')
      else
        flash.now[:alert] = t('flash.actions.shop.update.failure')  # flash.now[:error] から flash.now[:alert] に修正
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @shop.destroy
        redirect_to shops_url, notice: t('flash.actions.shop.destroy.success')
      else
        redirect_to shops_url, alert: t('flash.actions.shop.destroy.failure')
      end
    end

    private

    def set_shop
      @shop = Shop.find(params[:id])
    end

    # Shopモデルに設定された全てのタグを取得
    def set_tags
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
