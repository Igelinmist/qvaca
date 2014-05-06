class UsersController < ApplicationController

  def new
    @user = User.new
    render layout: false
  end

  def index
  end

  def edit
  end

end
