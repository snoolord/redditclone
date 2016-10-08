class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to subs_url
    else
      render :new
    end
  end

  def create
    @user = User.find_by_credentials(
      session_params[:username],
      session_params[:password])
    if @user
      login_user!(@user)
      redirect_to subs_url
    else
      flash[:errors] =  @user.errors.full_messages
      redirect_to new_session_url
    end
  end

  def destroy
    logout!
    redirect_to subs_url
  end
  private
  def session_params
    params.require(:session).permit(:username, :password)
  end
end
