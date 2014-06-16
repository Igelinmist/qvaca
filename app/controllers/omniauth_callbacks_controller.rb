class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    authorize(request.env['omniauth.auth'])
  end

  def twitter
    @user = User.find_for_oauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    end
  end

  private

  def authorize(auth_params)
    @user = User.find_for_oauth(auth_params)
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: auth_params.provider.capitalize) if is_navigational_format?
    end
  end
end