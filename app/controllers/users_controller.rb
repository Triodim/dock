class UsersController < ApplicationController

  # # GET /users
  # # GET /users.json
  def index
    result = User::Index.(params: params, current_user: current_user)

    if result.success?
      @users = result[:model]
    else
      flash.notice = 'Sorry, only admin can do this!'
      redirect_to posts_path
    end

  end

  # GET /users/1
  # GET /users/1.json
  def show
    result = User::Show.(params: params, current_user: current_user)
    if result.success?
      @user = result[:model]
    else
      flash.notice = 'User was not found!'
      redirect_to users_path
    end
  end

  # GET /users/new
  def new
    result = User::Create::Present.(params: params)
    if result.success?
      @user = result[:model]
    else
      flash.notice = 'The page was not found!'
      redirect_to users_path
    end
  end

  # GET /users/1/edit
  def edit
    result = User::Update::Present.(params: params)

    if result.success?
      @user = result[:model]
    else
      flash.notice = 'User was not found!'
      redirect_to users_path
    end
  end

  # POST /users
  # POST /users.json
  def create
    #TODO
    # + step 1 - upload img from form
    # + step 2 - upload img to the cloud
    # + step 3 - get img public_id
    # + step 4 - set public_id to user.avatar and save to db
    # + step 5 - take the img to the +show +index views
    # + step 6 - edit view of edit))
    # + step 7 - update update action)) i`m at one`s best))
    # + step 8 - get all this stuff to the trb create operation
    # step 9 - get all this stuff to the trb update operation

    result = User::Create.(params: params)

    if result.success?
      flash.notice = "User \"#{result[:model][:nickname]}\" was successfully created!"
      redirect_to users_path
    else
      flash.notice = "Sorry, user not saved! Something went wrong!"
      redirect_to new_user_path
    end

  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update

    @user = User::Update.(params: params)
    if @user.success?
      flash.notice = "The post \"#{@user[:model][:nickname]}\" was successfully saved!"
      redirect_to users_path
    else
      flash.notice = "Sorry, not update!#{@user["contract.default"].errors.messages}"
      redirect_to edit_user_path(@user[:model])
    end

  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy

    user = User::Show.(params: params, current_user: current_user)

    if user.success?
      del = User::Delete.(params: params)[:model]

      flash.notice = "User #{user[:model][:nickname]} was deleted"
      redirect_to users_path
    else
      flash.notice = "User was not found"
      redirect_to users_path
    end
  end
end
