class ApplicationController < ActionController::Base
  before_action :set_ransack_search_object

  private

  def set_ransack_search_object
    @q = Shop.ransack(params[:q])
  end

end
