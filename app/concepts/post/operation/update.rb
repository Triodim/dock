class Post::Update < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(Post, :find_by)
    step Policy::Pundit(PostPolicy, :update?)
    step Contract::Build(constant: Post::Contract::Create)
  end

  step Nested(Present)
  step Contract::Validate(key: :post)
  step Contract::Persist()
end