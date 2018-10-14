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
    session[:user_id] = nil
    redirect_to posts_path, notice: "User #{session[:user_nickname]} logged out"
  end
end
