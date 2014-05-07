class UsersController < ApplicationController

  def new
    @user = User.new
    render layout: false
  end

  def index
  end

  def edit
  end

  def show
    render layout: false
  end

  def create
    @user = User.create(user_params)
    if @user.save
      redirect_to(@user, notice: 'You successfully registered')
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :first_name, :last_name, :email)
  end

end
