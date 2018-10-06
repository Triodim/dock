class Category::Index < Trailblazer::Operation

  step :show_all

  def show_all(options, **)
  #result = ::Category.all
  result = ::Category.includes(:user)
    if result.empty?
      return false
    else
      options[:model] = result
    end
  end
end