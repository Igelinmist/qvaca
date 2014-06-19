class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do
    render file: "#{Rails.root}/public/403.html", status: 403, layout: false
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit({
      profile_attributes: [:display_name, :real_name, :website,
      :location, :birthday, :about_me, :weekly_email, :avatar],
      authorizations_attributes: [:provider, :uid] },
      :email, :password, :password_confirmation) }

    devise_parameter_sanitizer.for(:account_update) { |u| u.permit({
      profile_attributes: [:display_name, :real_name, :website, :location,
      :birthday, :about_me, :weekly_email, :avatar, :id] }, :email,
      :password, :password_confirmation, :current_password) }
  end

end
