class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json

  def index
    @posts = Post::Index.()[:model]
    @cats = Category::Index.()[:model].collect{|c| [c.id, c.name]} #is the same result as @cats = Category.all
    #puts "Cats =>#{@cats.assoc(1)[1]}"

  end

  # GET /posts/1
  # GET /posts/1.json
  def show

    @post = Post::Show.(params: params )[:model]
    @cat_name = Category.find_by_id(@post.category_id).name
    #puts "Cat name =>#{@cat_name.inspect}"

  end

  # GET /posts/new
  def new

    @post = Post::Create.(params: params)[:model]
    @cats = Category::Index.()[:model]

  end

  # GET /posts/1/edit
  def edit

    @post = Post::Update::Present.(params: params)[:model]
    @cats = Category::Index.()[:model]

  end

  # POST /posts
  # POST /posts.json
  def create
    post = Post::Create.(params: params)
    #binding.pry
    #puts "Result Create => #{result.inspect}"
    if post.success?
      flash.notice = "The post \"#{params[:post][:title]}\" was successfully saved!"
      redirect_to posts_path
    else
      title = post["result.contract.default"].errors.messages[:title][0]
      body = post["result.contract.default"].errors.messages[:body][0]
      flash.notice = "Sorry, not saved! The problem is that: \"#{title || body}\"."
      flash.now[:alert] = 'Error while sending message!'
      redirect_to new_post_path
    end

  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @post = Post::Update.(params: params)

    #puts "Result Update => #{@result["contract.default"]}"

    if @post.success?
      flash.notice = "The post \"#{params[:post][:title]}\" was successfully saved!"
      #flash[:alert] = 'ALERT'
      redirect_to posts_path
    else
      title = @post["contract.default"].errors[:title][0]
      body = @post["contract.default"].errors[:body][0]
      flash.notice = "Sorry, not update! The problem is that: \"#{title || body}\"."
      redirect_to edit_post_path(@post[:model])
    end


  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post::Delete.(params: params)

    flash.notice = "The post was successfully deleted!"

    redirect_to posts_path

  end

end
