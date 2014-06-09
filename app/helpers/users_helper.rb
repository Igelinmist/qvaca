module UsersHelper
  def setup_ext_attr(user)
    user.profile ||= Profile.new
  end
end