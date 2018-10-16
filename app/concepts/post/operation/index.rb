class Post::Index < Trailblazer::Operation

  step :show_all

  def show_all(options, **)
    result = ::Post.all
    if result.empty?
      return false
    else
      options[:model] = result
    end
  end
end
