class Post::Index < Trailblazer::Operation

  step :show_all_posts

  def show_all_posts(options, **)

    # options[:model] = ::Post.joins(:category).select('posts.*, categories.name as cat_name')

    result = ::Post.joins(:category).select('posts.*, categories.name as cat_name')
    if result.empty?
      return false
    else
      options[:model] = result
    end

  end

end
