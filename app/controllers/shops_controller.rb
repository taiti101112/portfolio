class ShopsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show map]
  before_action :set_tags # 全てのアクションで @tags を利用可能にする
  before_action :set_is_admin, only: %i[index show favorites]

  def index
    if params[:q].present?

      key_words = params[:q][:name_cont].split(/[\p{blank}\s]+/)

      grouping_hash = key_words.reduce({}) do |hash, word|
        hash.merge(word => { name_cont: word })
      end

    end

    @q = Shop.ransack({
                        combinator: 'and',
                        groupings: grouping_hash
                      })

    # 検索条件がある場合は検索条件に当てはまるショップを取得し、ない場合は全てのショップを取得
    @shops = if params[:q].present? && params[:q][:name_cont].present?
               @q.result(distinct: true).includes(:business_hours)
             else
               # 検索条件がない場合は全ショップを取得
               Shop.includes(:business_hours).all
             end

    # タグに当てはまるショップを取得
    @shops = @shops.tagged_with(params[:tag_name]) if params[:tag_name].present?

    # 営業中のショップを取得
    @shops = @shops.open_now if params[:open_now] == '1'

    # 五十音順に並び替え
    @shops = @shops.order(:name)

    # ショップの数を数える
    @shop_count = @shops.count

    # ページネーション
    @shops = @shops.page(params[:page]).per(12)

    # JavaScriptに情報を渡す
    gon.shops = @shops
  end

  def show
    @shop = Shop.find(params[:id])
  end

  # お気に入り登録
  def favorites
    @favorite_shops = current_user.favorite_shops.includes(:user).order(created_at: :desc)
  end

  def map
    if params[:q].present?

      key_words = params[:q][:name_cont].split(/[\p{blank}\s]+/)

      grouping_hash = key_words.reduce({}) do |hash, word|
        hash.merge(word => { name_cont: word })
      end

    end

    @q = Shop.ransack({
                        combinator: 'and',
                        groupings: grouping_hash
                      })

    # 検索条件がある場合は検索条件に当てはまるショップを取得し、ない場合は全てのショップを取得
    @shops = if params[:q].present? && params[:q][:name_cont].present?
               @q.result(distinct: true).includes(:business_hours)
             else
               # 検索条件がない場合は全ショップを取得
               Shop.includes(:business_hours).all
             end

    # タグに当てはまるショップを取得
    @shops = @shops.tagged_with(params[:tag_name]) if params[:tag_name].present?

    # 営業中のショップを取得
    @shops = @shops.open_now if params[:open_now] == '1'

    # 五十音順に並び替え
    @shops = @shops.order(:name)

    # ショップの数を数える
    @shop_count = @shops.count

    # ページネーション
    @shops = @shops.page(params[:page]).per(12)

    # JavaScriptに情報を渡す
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
