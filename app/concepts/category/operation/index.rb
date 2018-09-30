class Category::Index < Trailblazer::Operation

  step :show_all_cats

  def show_all_cats(options, **)
    #options[:model] = ::Category.all
  result = ::Category.all
    if result.empty?
      return false
    else
      options[:model] = result
    end
  end
end