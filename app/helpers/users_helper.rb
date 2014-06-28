module UsersHelper
  def setup_ext_attr(user)
    user.profile ||= user.build_profile
    user
  end
end