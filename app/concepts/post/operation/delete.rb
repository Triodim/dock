require "trailblazer/operation"

class Post::Delete < Trailblazer::Operation

  step Model(Post, :find_by)
  step :delete


  def delete(options, model:, **)
    options["title"] = model.title
    model.destroy
  end


end