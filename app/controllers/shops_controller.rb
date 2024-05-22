# app/controllers/shops_controller.rb

class ShopsController < ApplicationController

  def index
    @q = Shop.ransack(params[:q])
    if params[:q].present?
      @shops = @q.result(distinct: true)
    else
      @shops = Shop.all
    end
  end

  def show
    @shop = Shop.find(params[:id])
  end
end
