class User::Index < Trailblazer::Operation

  step :show_all

  def show_all(options, **)

    # options[:model] = ::Post.joins(:category).select('posts.*, categories.name as cat_name')

    result = ::User.where(active: true)
    if result.empty?
      return false
    else
      options[:model] = result
    end

  end

end