class Post::Show < Trailblazer::Operation

  step Model(Post, :find_by)

  step :note

  def note(options, *)
    puts "Model is => #{options[:model]}"
    true
  end

end