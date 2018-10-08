class Post::Index < Trailblazer::Operation

  step :show_all

  def show_all(options, **)

    # options[:model] = ::Post.joins(:category).select('posts.*, categories.name as cat_name')
    #result = ::Post.joins(:category).select('posts.*, categories.name as cat_name')

    options[:model] = ::Post.joins(:category).select('posts.*, categories.name as cat_name')

    options[:model].present?

  end

end
