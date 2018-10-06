class Post::Index < Trailblazer::Operation

  step :show_all

  def show_all(options, **)

    # options[:model] = ::Post.joins(:category).select('posts.*, categories.name as cat_name')

    result = ::Post.joins(:category).select('posts.*, categories.name as cat_name')
    #puts "Posts join = > #{result.inspect}"
    if result.empty?
      return false
    else
      options[:model] = result
    end

  end

end
