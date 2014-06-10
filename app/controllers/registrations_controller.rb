class RegistrationsController < Devise::RegistrationsController
  
  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, 
      profile_attributes: [:display_name, :real_name, :website, :location,
        :birthday, :about_me, :weekly_email, :avatar])
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, 
      :current_password, profile_attributes: [:display_name, :real_name,
        :website, :location, :birthday, :about_me, :weekly_email, :avatar, :id])
  end
    
end