module UsersHelper
  def setup_ext_attr(user)
    user.profile ||= user.build_profile
    user
  end

  def build_oauth_for(user)
    if session[:provider]
      user.authorizations.build(provider: session[:provider], uid: session[:uid])
      user.profile.display_name = session[:nickname]
      user.profile.real_name = session[:name]
    end
  end
end