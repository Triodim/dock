class Post::Create < Trailblazer::Operation

  class Present < Trailblazer::Operation
    step Model(Post, :new)
    pass :prepare_params
    step Contract::Build( constant: Post::Contract::Create )

    def prepare_params(options, user:, **)
      options[:params][:post].merge!(user_id: user.id) if options[:params][:post].present?
    end
  end

  step Nested(Present)
  step Contract::Validate(key: :post)                      #run validation of input - problem here with messages!
  step Contract::Persist()                                #run post.save (or model.save) instead of step :save_new_post


end
