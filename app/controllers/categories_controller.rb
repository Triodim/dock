class CategoriesController < ApplicationController
  def index
    result = Category::Index.()
    if result.success?
      @cats = result[:model]
    else
      flash.notice = 'Sorry, there are no saved categories!'
      redirect_to new_category_path
    end
  end

  def show
    result = Category::Show.(params: params)
    if result.success?
      @cat = result[:model]
    else
      flash.notice = 'The category was not found!'
      redirect_to categories_path
    end
  end

  def new
    result = Category::Create::Present.(params: params, current_user: current_user)
    if result.success?
      @cat = result[:model]
    else
      flash.notice = result["result.policy.default"]["message"]
      redirect_to categories_path
    end
  end

  def edit
    result = Category::Update::Present.(params: params, current_user: current_user)
    if result.success?
      @cat = result[:model]
    else
      flash.notice = 'Only admin can do this!'
      redirect_to categories_path
    end
  end

  def create
    cat = Category::Create.(params: params, current_user: current_user)
      if cat.success?
        flash.notice = "The category \"#{cat[:model][:name]}\" was successfully saved!"
        redirect_to categories_path
      else
        error_message = cat["result.contract.default"].errors.messages[:name][0]
        flash.notice = "Sorry, not saved! The problem is that: \"#{error_message}\"."
        redirect_to new_category_path
      end
  end

  def update
    @cat = Category::Update.(params: params, current_user: current_user)
    if @cat.success?
      flash.notice = "The category \"#{params[:category][:name]}\" was successfully saved!"
      redirect_to categories_path
    else
      name = @cat["contract.default"].errors[:name][0]
      flash.notice = "Sorry, not update! The problem is that: \"#{name}\"."
      redirect_to edit_category_path(@cat[:model])
    end
  end

  def destroy
    result = Category::Delete.(params: params, current_user: current_user)
    flash.notice = result.success? ? "The category was successfully deleted!" : "You are not admin, sorry!"
    redirect_to categories_path
  end
end
