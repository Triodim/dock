class Category::Create < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(Category, :new)                                    #create a cat by calling Category.new
    # step :prepare_parmas
    step Contract::Build( constant: Category::Contract::Create )
  end

  step Nested(Present)
  step Contract::Validate(key: :category)                         #run validation of input - problem here with messages!
  step Contract::Persist()                                        #run category.save (or model.save) instead of step :save_new_post
end
