class Category::Show < Trailblazer::Operation

  step Model(Category, :find_by)
  step Contract::Validate(key: :category)

end