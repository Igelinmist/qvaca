class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    authorize(request.env['omniauth.auth'])
  end

  def twitter
    authorize(request.env['omniauth.auth'])
  end

  protected

  def authorize(auth_params)
    @user = User.find_for_oauth(auth_params)
    if @user && @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: auth_params.provider.capitalize) if is_navigational_format?
    else
      @user = User.create
      @user.build_profile(display_name: auth_params.info[:nickname], real_name: auth_params.info[:name])
      redirect_to new_user_registration_url, resource: @user
    end
  end
end