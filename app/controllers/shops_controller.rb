class ShopsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :map]
  before_action :set_tags # 全てのアクションで @tags を利用可能にする
  before_action :set_is_admin, only: [:index, :show, :favorites]

  def index
    @q = Shop.ransack(params[:q])
    if params[:q].present?
      @shops = @q.result(distinct: true).includes(:business_hours)
    else
      @shops = Shop.includes(:business_hours).all
    end
  
    if params[:tag_name]
      @shops = @shops.tagged_with(params[:tag_name])
    end
  
    if params[:open_now] == '1'
      @shops = @shops.open_now
    end
  
    @shops = @shops.page(params[:page]).per(5)
    gon.shops = @shops
  end

  def show
    @shop = Shop.find(params[:id])
    # @tags = @shop.tag_counts_on(:tags) # 個別のショップのタグを別の変数に保持
  end

  def favorites
    @favorite_shops = current_user.favorite_shops.includes(:user).order(created_at: :desc)
  end

  def map
    @q = Shop.ransack(params[:q])
    if params[:q].present?
      @shops = @q.result(distinct: true).includes(:business_hours)
    else
      @shops = Shop.includes(:business_hours).all
    end
  
    if params[:tag_name]
      @shops = @shops.tagged_with(params[:tag_name])
    end
  
    if params[:open_now] == '1'
      @shops = @shops.select { |shop| shop.open_now? }
    end
    
    gon.shops = @shops
  end

  private

  def set_tags
    @tags = ActsAsTaggableOn::Tag.for_context(:tags).most_used
  end

  def set_is_admin
    @is_admin = current_user&.admin?
  end
end
