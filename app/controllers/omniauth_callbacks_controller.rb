class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    authorize(request.env['omniauth.auth'])
  end

  def twitter
    authorize(request.env['omniauth.auth'])
  end

  protected

  def authorize(auth_params)
    session['devise.omniauth'] = user_data(auth_params)
    @user = User.find_for_oauth(auth_params)
    if @user && @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: auth_params.provider.capitalize) if is_navigational_format?
    else
      redirect_to new_user_registration_url, resource: User.create,
        notice: %q(
          Для полноценной работы с приложением нужно зарегистрировать email и пароль.
          Это необходимо сделать один раз. В дальнейшем вход будет осуществлен автоматически.)
    end
  end

  def user_data(oauth_hash)
    { provider: oauth_hash.provider, uid: oauth_hash.uid, email: oauth_hash.email,
      display_name: oauth_hash.info['nickname'], real_name: oauth_hash.info['name'],
      avatar: oauth_hash.info['image'], email: oauth_hash.info['email'] }
  end
end