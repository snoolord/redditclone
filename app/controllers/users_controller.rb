class UsersController < ApplicationController

  def new
    if logged_in?
      redirect_to users_url
    else
      @user = User.new
      render :new
    end
  end

  def index
    render :index
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login_user!(@user)
      redirect_to subs_url
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
