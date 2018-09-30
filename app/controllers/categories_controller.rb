class CategoriesController < ApplicationController


  def index
    # @cats = Category::Index.()[:model]

  result = Category::Index.()

    if result.success?
      @cats = result[:model]
    else
      flash.notice = 'Sorry, there are no saved categories!'
      redirect_to new_category_path
    end

  end

  def show
    #@cat = Category::Show.(params: params)[:model]

    result = Category::Show.(params: params)

    if result.success?
      @cat = result[:model]
    else
      flash.notice = 'The category was not found!'
      redirect_to categories_path
    end

  end

  def new
  #@cat = Category::Create::Present.(params: params)[:model]

  result = Category::Create::Present.(params: params)

    if result.success?
      @cat = result[:model]
    else
      flash.notice = 'The page was not found!'
      redirect_to categories_path
    end

  end

  def edit
    # @cat = Category::Update::Present.(params: params)[:model]

    result = Category::Update::Present.(params: params)
    if result.success?
      @cat = result[:model]
    else
      flash.notice = 'The category was not found!'
      redirect_to categories_path
    end


  end

  def create

    cat = Category::Create.(params: params)
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

    @cat = Category::Update.(params: params)

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
    # @cat = Category::Delete.(params: params)
    result = Category::Delete.(params: params)

    if result.success?
      flash.notice = "The category was successfully deleted!"
      redirect_to categories_path
    else
      flash.notice = "The category was not found!"
      redirect_to categories_path
    end
  end

end
