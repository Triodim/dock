class Post::Delete < Trailblazer::Operation

  step Model(Post, :find_by)
  step Policy::Pundit( PostPolicy, :destroy? )
  step :delete

  def delete(options, model:, **)
    model.destroy
  end
end