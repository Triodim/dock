class Category::Index < Trailblazer::Operation
  step :show_all_cats

  def show_all_cats(options, **)
    options["category"] = ::Category.all
  end
end