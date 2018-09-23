class Category::Create < Trailblazer::Operation

  step Model( Category, :new )                                 #create a cat by calling Category.new
  step Contract::Build( constant: Category::Contract::Create ) #fillin properties of the cat with params
  step Contract::Validate(key: :category)                      #run validation of input - problem here with messages!
  step Contract::Persist()                                     #run category.save (or model.save) instead of step :save_new_post

end