class Post::Create < Trailblazer::Operation

  step Model( Post, :new )                                 #create a post by calling Post.new
  step Contract::Build( constant: Post::Contract::Create ) #fillin properties of the post with params
  step Contract::Validate(key: :post)                      #run validation of input - problem here with messages!
  step Contract::Persist()                                 #run post.save (or model.save) instead of step :save_new_post

end