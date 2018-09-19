require "trailblazer/operation"

class Post::Index < Trailblazer::Operation

  step :show_all_posts


  def show_all_posts(options, **)
    options["post"] = ::Post.all
    true
  end


end