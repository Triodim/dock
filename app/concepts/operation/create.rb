require "trailblazer/operation"

class Post::Create < Trailblazer::Operation

  step :make_new_post!

  step :notify!

  def make_new_post!(options, params:, **)
    post = Post.new
    options["post"] = post
    post.title = params[:post][:title]
    post.body = params[:post][:body]
    post.save
    #post.update_attributes(params[:post])
    puts "The post #{post.title} was successfully saved!"
    true
  end


  def notify!(options, params:, post:, **)
    puts "Last title is: #{params[:post][:title]}"
    #flash.notice = "The post #{params[:post][:title]} was successfully saved!"
  end

end