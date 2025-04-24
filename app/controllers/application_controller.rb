class ApplicationController < ActionController::Base
  before_action :set_ransack_search_object
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email name])
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[email password])
  end

  def after_sign_in_path_for(resource)
    Rails.logger.info "User signed in with ID: #{resource.id}" if resource
    user_path(resource.id)
  end

  private

  def set_ransack_search_object
    @q = Shop.ransack(params[:q])
  end

  def authenticate_admin!
    return if current_user && current_user.admin?

    redirect_to root_path
  end
end
