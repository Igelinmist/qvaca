class ProfilesController < InheritedResources::Base
  respond_to :html
  actions :show, :edit, :update

  def edit
    session[:return_to] ||= request.referer
    super
  end

  def update
    update! { session.delete(:return_to) }
  end

  protected

  def resource
    @profile ||= end_of_association_chain.find(params[:id]).decorate
  end

  def profile_params
    params.require(:profile).permit(:display_name, :real_name, :birthday, :website, :about_me, :weekly_email, :avatar, :location)
  end
end
