class PostsController < ApplicationController

  def index

    result_cat = Category::Index.()
    result = Post::Index.()
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
    result = Post::Create::Present.(params: params, current_user: current_user)
    return unless result['result.policy.default'].success?
    if result.success?
      @post = result[:model]
      @cats = Category::Index.()[:model]
    else
      flash.notice = 'The page was not found!'
      redirect_to posts_path
    end
  end

  def edit
    result = Post::Update::Present.(params: params, current_user: current_user)
    if result.success?
      @cats = Category::Index.()[:model]
      @post = result[:model]
    else
      flash.notice = 'The post was not found!'
      redirect_to posts_path
    end
  end

  def create
    result = Post::Create.(params: params, current_user: current_user)
    if result.success?
      flash.notice = "The post \"#{result[:model][:title]}\" was successfully saved!"
      redirect_to posts_path
    else
      flash.notice = "Sorry, not saved! The problem is that: \"#{result["result.contract.default"].errors.messages}\"."
      redirect_to new_post_path
    end
  end

  def update
    @post = Post::Update.(params: params, current_user: current_user)
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
    result = Post::Delete.(params: params, current_user: current_user)
    if result.success?
      flash.notice = "The post was successfully deleted!"
      redirect_to posts_path
    else
      flash.notice = "The post was not found!"
      redirect_to posts_path
    end
  end

end
