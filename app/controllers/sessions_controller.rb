class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(nickname: params[:nickname])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      session[:user_nickname] = @user.nickname
      redirect_to users_path, notice: "User #{@user.nickname} successfull logged in!"
    else
      redirect_to login_url, notice: "Invalid user/password combination"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to users_path, notice: "User #{session[:user_nickname]} logged out"
  end
end
