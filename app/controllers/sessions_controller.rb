class SessionsController < ApplicationController
  def new
  end

  def create
    result = User::Authenticate.(params: params)
    if result.success?
      session[:user_id] = result[:model][:id]
      redirect_to posts_path, notice: "User #{result[:model][:nickname]} successfull logged in!"
    else
      redirect_to login_url, notice: "Invalid user/password combination"
    end
  end

  def destroy
    redirect_to posts_path, notice: "User #{current_user.nickname} logged out"
    session[:user_id] = nil
  end
end
