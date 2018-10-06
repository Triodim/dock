class UsersController < ApplicationController
  #before_action :set_user, only: [:show, :destroy]

  # # GET /users
  # # GET /users.json
  def index
    result = User::Index.()
    #binding.pry

      if result.success?
        @users = result[:model]
      else
        flash.notice = 'Sorry, there are no saved users!'
        redirect_to new_user_path
      end

  end

  # GET /users/1
  # GET /users/1.json
  def show
    result = User::Show.(params: params)

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
    #binding.pry
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

    result = User::Create.(params: params)

    if result.success?
      flash.notice = "User \"#{result[:model][:nickname]}\" was successfully created!"
      redirect_to users_path
    else
      flash.notice = "Sorry, user not saved! Something went wrong!"
      redirect_to new_user_path#, alert: "Sorry, user not saved! Something went wrong!"
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

    user = User::Show.(params: params)

    if user.success?
      user[:model][:active] = false
      user[:model].save
      flash.notice = "User #{user[:model][:nickname]} was deleted"
      redirect_to users_path
    else
      flash.notice = "User was not found"
      redirect_to users_path
    end
  end
    # @user.destroy
    # respond_to do |format|
    #   format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    #   format.json { head :no_content }
    # end

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_user
  #     @user = User.find(params[:id])
  #   end
  #
  #   # Never trust parameters from the scary internet, only allow the white list through.
  #   def user_params
  #     params.require(:user).permit(:nickname, :email, :password, :password_confirmation, :avatar, :active)
  #   end

end
