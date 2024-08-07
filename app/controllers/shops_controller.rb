class ShopsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_tags, only: [:index, :show]
  before_action :set_is_admin, only: [:index, :show, :favorites]

  def index
    @q = Shop.ransack(params[:q])
    
    if params[:q].present?
      @shops = @q.result(distinct: true).includes(:business_hours)
    else
      @shops = Shop.includes(:business_hours).all
    end
  
    # タグで絞り込む
    if params[:tag_name]
      @shops = @shops.tagged_with(params[:tag_name])
    end
  
    # 営業中の店舗のみをフィルタリング
    if params[:open_now] == '1'
      @shops = @shops.select { |shop| shop.open_now? }
    end
  end

  def show
    @shop = Shop.find(params[:id])
    @tags = @shop.tag_counts_on(:tags)
  end

  def favorites
    @favorite_shops = current_user.favorite_shops.includes(:user).order(created_at: :desc)
  end

  private

  def set_tags
    # Shopモデルに設定された全てのタグを取得
    @tags = ActsAsTaggableOn::Tag.for_context(:tags).most_used
  end

  def set_is_admin
    @is_admin = current_user&.admin?
  end
end
