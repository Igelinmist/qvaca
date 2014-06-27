class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def all
    oauth = request.env['omniauth.auth']

    user = User.find_for_oauth(oauth)
    if user.persisted?
      sign_in_and_redirect user, event: :authentication
      set_flash_message(:notice, :success, kind: oauth.provider.capitalize) if is_navigational_format?
    else
      session['devise.oauth_attributes'] = oauth.except('extra')

      redirect_to new_user_registration_url,
        notice: %q(
          Для полноценной работы с приложением нужно зарегистрировать email и пароль.
          Это необходимо сделать один раз. В дальнейшем вход будет осуществлен автоматически.)
    end
  end

  alias_method :twitter, :all
  alias_method :facebook, :all

end
