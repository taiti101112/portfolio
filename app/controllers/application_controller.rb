class ApplicationController < ActionController::Base
  before_action :set_ransack_search_object
  before_action :configure_permitted_parameters, if: :devise_controller? 

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end

  def after_sign_in_path_for(resource)
    user_path(resource.id)
  end

  private

  def set_ransack_search_object
    @q = Shop.ransack(params[:q])
  end

end

