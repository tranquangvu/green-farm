class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource_or_scope)
    case true
    when resource_or_scope.is_a?(User)
      @farm = Farm.first
      inspecter_dashboard_path(@farm)
    when resource_or_scope.is_a?(Admin)
      rails_admin_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :avatar, :avatar_cache])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :avatar, :avatar_cache])
  end
end
