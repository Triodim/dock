class Category::Update < Trailblazer::Operation

  class Present < Trailblazer::Operation
    step Category::Show #Model(Category, :find_by)
    step Contract::Build( constant: Category::Contract::Create )
  end

  step Nested(Present)
  step Contract::Validate( key: :category )
  step Contract::Persist()

end