class ApplicationController < ActionController::Base
  include Pundit

  helper_method :current_user
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def current_user
    @current_user ||= User::Find.(session_id: session[:user_id])[:model] if session[:user_id]
  end

  private

  def user_not_authorized
    flash.notice = 'Authorized please to perform this action.'
    redirect_to posts_path
  end
end
