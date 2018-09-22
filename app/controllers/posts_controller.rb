class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  # TODO: check reslut
  def index
    @result = Post::Index.()["post"]
  end

  # GET /posts/1
  # GET /posts/1.json
  def show

    @result = Post::Show.(params: params )[:model]

    #puts "Result => #{@result.inspect}"
  end

  # GET /posts/new
  def new

    @result = Post::Create.(params: params)[:model]
    @cats = Category::Index.()["category"]

  end

  # GET /posts/1/edit
  def edit

    @result = Post::Update::Present.(params: params)[:model]
    @cats = Category::Index.()["category"]

  end

  # POST /posts
  # POST /posts.json
  def create
    result = Post::Create.(params: params)
    #binding.pry
    #puts "Result Create => #{result.inspect}"
    if result.success?
      flash.notice = "The post \"#{params[:post][:title]}\" was successfully saved!"
      redirect_to posts_path
    else
      title = result["result.contract.default"].errors.messages[:title][0]
      body = result["result.contract.default"].errors.messages[:body][0]
      flash.notice = "Sorry, not saved! The problem is that: \"#{title || body}\"."
      redirect_to new_post_path
    end

  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @result = Post::Update.(params: params)

    #puts "Result Update => #{@result["contract.default"]}"

    if @result.success?
      flash.notice = "The post \"#{params[:post][:title]}\" was successfully saved!"
      #flash[:alert] = 'ALERT'
      redirect_to posts_path
    else
      title = @result["contract.default"].errors[:title][0]
      body = @result["contract.default"].errors[:body][0]
      flash.notice = "Sorry, not update! The problem is that: \"#{title || body}\"."
      redirect_to edit_post_path(@result[:model])
    end


  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @result = Post::Delete.(params: params)
    #puts "Result Delete => #{@result.inspect}"
    #puts "Params Delete => #{params.inspect}"

    flash.notice = "The post was successfully deleted!" #How to notice a title of deleted post?
    redirect_to posts_path

  end

end
