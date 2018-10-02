class PostsController < ApplicationController

  def index

     result = Post::Index.()
     result_cat = Category::Index.()
     #binding.pry

     if result_cat.success?
       if result.success?
        @posts = result[:model]
       else
        flash.notice = 'Sorry, there are no saved posts!'
        redirect_to new_post_path
       end
     else
       flash.notice = 'Sorry, there are no saved categories!'
       redirect_to new_category_path
     end

  end

  def show

    result = Post::Show.(params: params)

    if result.success?

      @post = result[:model]

    else

      flash.notice = 'The post was not found!'
      redirect_to posts_path

    end

  end

  def new

    #@post = Post::Create::Present.(params: params)[:model]

    result = Post::Create::Present.(params: params)
    if result.success?
      @post = result[:model]
      @cats = Category::Index.()[:model]
    else
      flash.notice = 'The page was not found!'
      redirect_to posts_path
    end


  end


  def edit

    #@post = Post::Update::Present.(params: params)[:model]

    result = Post::Update::Present.(params: params)

    if result.success?
      @cats = Category::Index.()[:model]
      @post = result[:model]
    else
      flash.notice = 'The post was not found!'
      redirect_to posts_path
    end

  end


  def create

    result = Post::Create.(params: params)

    if result.success?
      flash.notice = "The post \"#{result[:model][:title]}\" was successfully saved!"
      redirect_to posts_path
    else
      title = result["result.contract.default"].errors.messages[:title][0]
      body = result["result.contract.default"].errors.messages[:body][0]
      flash.notice = "Sorry, not saved! The problem is that: \"#{title || body}\"."
      redirect_to new_post_path
    end

  end


  def update

    @post = Post::Update.(params: params)

    if @post.success?
      flash.notice = "The post \"#{@post[:model][:title]}\" was successfully saved!"
      redirect_to posts_path
    else
      title = @post["contract.default"].errors[:title][0]
      body = @post["contract.default"].errors[:body][0]
      flash.notice = "Sorry, not update! The problem is that: \"#{title || body}\"."
      redirect_to edit_post_path(@post[:model])
    end

  end

  def destroy

    #@post = Post::Delete.(params: params)

    result = Post::Delete.(params: params)

    if result.success?
      flash.notice = "The post was successfully deleted!"
      redirect_to posts_path
    else
      flash.notice = "The post was not found!"
      redirect_to posts_path
    end

  end

end
