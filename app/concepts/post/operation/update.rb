require "trailblazer/operation"

class Post::Update < Trailblazer::Operation

  class Present < Trailblazer::Operation
    step Model(Post, :find_by)
    step Contract::Build( constant: Post::Contract::Create )
  end

  step Nested(Present)
  step Contract::Validate( key: :post )
  step Contract::Persist()

=begin
  step :note

  def note(options, *)
    puts "Model is => #{options.inspect}"
    true
  end
=end

end