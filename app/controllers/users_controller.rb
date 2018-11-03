class UsersController < ApplicationController

  def index
    result = User::Index.(params: params, current_user: current_user)

    if result.success?
      @users = result[:model]
    else
      flash.notice = 'Sorry, only admin can do this!'
      redirect_to posts_path
    end

  end

  def show
    result = User::Show.(params: params, current_user: current_user)
    if result.success?
      @user = result[:model]
    else
      flash.notice = 'User was not found!'
      redirect_to users_path
    end
  end

  def new
    result = User::Create::Present.(params: params)
    if result.success?
      @user = result[:model]
    else
      flash.notice = 'The page was not found!'
      redirect_to users_path
    end
  end

  def edit
    result = User::Update::Present.(params: params, current_user: current_user)

    if result.success?
      @user = result[:model]
    else
      flash.notice = 'User was not found!'
      redirect_to users_path
    end
  end

  def create

    result = User::Create.(params: params)

    if result.success?
      flash.notice = "User \"#{result[:model][:nickname]}\" was successfully created! #{result[:ava_error]}"
      redirect_to users_path
    else
      flash.notice = "Sorry, user not saved! Something went wrong!"
      redirect_to new_user_path
    end

  end

  def update

    @user = User::Update.(params: params, current_user: current_user)
    if @user.success?
      flash.notice = "The user \"#{@user[:model][:nickname]}\" was successfully updated! #{@user[:ava_error]}"
      redirect_to users_path
    else
      flash.notice = "Sorry, not update!#{@user["contract.default"].errors.messages}"
      redirect_to edit_user_path(@user[:model])
    end

  end

  def destroy

    result = User::Delete.(params: params, current_user: current_user)

    if result.success?
      flash.notice = "User #{result[:model][:nickname]} was deleted"
      redirect_to users_path
    else
      flash.notice = "User was not found"
      redirect_to users_path
    end
  end
end
