class Category::Show < Trailblazer::Operation

  step Model(Category, :find_by)

end