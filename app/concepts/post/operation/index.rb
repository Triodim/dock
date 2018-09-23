class Post::Index < Trailblazer::Operation
  step :show_all_posts

  def show_all_posts(options, **)
    options[:model] = ::Post.all
  end
end
