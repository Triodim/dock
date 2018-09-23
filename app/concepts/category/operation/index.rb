class Category::Index < Trailblazer::Operation
  step :show_all_cats

  def show_all_cats(options, **)
    options[:model] = ::Category.all
  end
end