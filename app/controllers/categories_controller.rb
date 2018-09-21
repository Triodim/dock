class CategoriesController < ApplicationController
  #before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    @cats = Category::Index.()
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    # TODO: check reslt
    @cat = Category::Show.(params: params )
    #puts "Cat result => #{@cat[:model].inspect}"
  end

  # GET /categories/new
  def new
    @cat = Category::Create.(params: params)
  end

  # GET /categories/1/edit
  def edit
    @cat = Category::Update::Present.(params: params)
  end

  # POST /categories
  # POST /categories.json
  def create
    cat = Category::Create.(params: params)
    #binding.pry
    #puts "Cat Create => #{cat.inspect}"
    if cat.success?
      flash.notice = "The post \"#{params[:category][:name]}\" was successfully saved!"
      redirect_to categories_path
    else
      name = cat["result.contract.default"].errors.messages[:name][0]
      flash.notice = "Sorry, not saved! The problem is that: \"#{name}\"."
      redirect_to new_category_path
    end
  end


  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    @cat = Category::Update.(params: params)

    #puts "Cat Update => #{@cat["contract.default"]}"

    if @cat.success?
      flash.notice = "The post \"#{params[:category][:name]}\" was successfully saved!"
      redirect_to categories_path
    else
      name = @cat["contract.default"].errors[:name][0]
      flash.notice = "Sorry, not update! The problem is that: \"#{name}\"."
      redirect_to edit_category_path(@cat[:model])
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @cat = Category::Delete.(params: params)
    flash.notice = "The category was successfully deleted!" #How to notice a title of deleted post?
    redirect_to categories_path
  end

end
