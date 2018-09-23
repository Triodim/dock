class Post::Show < Trailblazer::Operation

  step Model(Post, :find_by)

end