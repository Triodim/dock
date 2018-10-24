class Post::Create < Trailblazer::Operation

  class Present < Trailblazer::Operation
    step Model(Post, :new)
    step Policy::Pundit( PostPolicy, :create? )
    pass :prepare_params
    step Contract::Build( constant: Post::Contract::Create )

    def prepare_params(options, current_user:, **)
      20.times do |index|
        MyWorker.perform_async(index, "Bobby")
      end
      options[:params][:post].merge!(user_id: current_user.id) if options[:params][:post].present?
    end
  end

  step Nested(Present)
  step Contract::Validate(key: :post)
  step Contract::Persist()


end
