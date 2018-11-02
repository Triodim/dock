class Post::Index < Trailblazer::Operation

  step :show_all

  def show_all(options, **)
    #binding.pry
    result = ::Post.where(deleted_at: nil)
    if result.empty?
      return false
    else
      options[:model] = result
    end
  end
end
