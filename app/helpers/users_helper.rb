module UsersHelper
  def setup_ext_attr(user)
    user.profile ||= user.build_profile
    user.profile.display_name = session[:nickname] if session[:nickname]
    user.profile.real_name = session[:name] if session[:name]
    user
  end
end