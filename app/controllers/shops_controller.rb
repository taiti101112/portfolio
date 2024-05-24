# app/controllers/shops_controller.rb

class ShopsController < ApplicationController
  before_action :set_tags


  def index
    @q = Shop.ransack(params[:q])
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
    @shop = Shop.find(params[:id])
    @tags = @shop.tag_counts_on(:tags)
  end
end

private

def set_tags
  # Shopモデルに設定された全てのタグを取得
  @tags = ActsAsTaggableOn::Tag.for_context(:tags).most_used
end