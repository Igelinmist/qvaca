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
      session[:provider] = auth_params.provider
      session[:uid] = auth_params.uid
      session[:nickname] = auth_params.info[:nickname]
      session[:name] = auth_params.info[:name]
      redirect_to new_user_registration_url, resource: User.create, 
        notice: %q(
          Для полноценной работы с приложением нужно зарегистрировать email и пароль.
          Это необходимо сделать один раз. В дальнейшем вход будет осуществлен автоматически.)
    end
  end
end