class ShopsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :map]
  before_action :set_tags # 全てのアクションで @tags を利用可能にする
  before_action :set_is_admin, only: [:index, :show, :favorites]

  def index
    # 検索条件を設定
    @q = Shop.ransack(params[:q])
  
    # 検索条件がある場合は検索条件に当てはまるショップを取得し、ない場合は全てのショップを取得
    if params[:q].present? && params[:q][:name_cont].present?
      @shops = @q.result(distinct: true).includes(:business_hours)
    else
      # 検索条件がない場合は全ショップを取得
      @shops = Shop.includes(:business_hours).all
    end
  
    # タグに当てはまるショップを取得
    if params[:tag_name].present?
      @shops = @shops.tagged_with(params[:tag_name])
    end
  
    # 営業中のショップを取得
    if params[:open_now] == '1'
      @shops = @shops.open_now
    end

    # 五十音順に並び替え
    @shops = @shops.order(:name)
  
    # ページネーション
    @shops = @shops.page(params[:page]).per(5)
  
    # JavaScriptに情報を渡す
    gon.shops = @shops
  end
  

  def show
    @shop = Shop.find(params[:id])
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