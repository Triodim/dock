class PostsController < ApplicationController
 # before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @result = Post::Index.()
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @result = Post::Show.(params: params )
    #puts "Result => #{@result[:model].inspect}"
  end

  # GET /posts/new
  def new
    @result = Post::Create.(params: params)
  end

  # GET /posts/1/edit
  def edit
    @result = Post::Update::Present.(params: params)

  end

  # POST /posts
  # POST /posts.json
  def create
    result = Post::Create.(params: params)
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

=begin
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
=end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @result = Post::Delete.(params: params)
    #puts "Result Delete => #{@result.inspect}"
    #puts "Params Delete => #{params.inspect}"

    flash.notice = "The post was successfully deleted!"
    redirect_to posts_path

=begin
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
=end
  end

=begin
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body)
    end
=end
end
