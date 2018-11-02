class Post::SoftDelete < Trailblazer::Operation

  step :posts_soft_delete

  def posts_soft_delete (options, user_id:, **)
    #binding.pry
    Post.where(user_id: user_id).update_all(deleted_at: Time.now, updated_at: Time.now)
  end

end