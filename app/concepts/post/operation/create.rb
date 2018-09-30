class Post::Create < Trailblazer::Operation

  class Present < Trailblazer::Operation
    step Model(Post, :new)
    step Contract::Build( constant: Post::Contract::Create )
    #binding.pry
  end

  step Nested(Present)
  step Contract::Validate(key: :post)                      #run validation of input - problem here with messages!
  step Contract::Persist()                                 #run post.save (or model.save) instead of step :save_new_post

end
