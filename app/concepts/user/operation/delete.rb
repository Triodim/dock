class User::Delete < Trailblazer::Operation

  step Model(User, :find_by)
  step Policy::Pundit( UserPolicy, :destroy? )
  step :set_active
  # step :set_posts_deleted_at

  def set_active(options, **)
    options[:model][:active] = false
    options[:model].save
  end

  # def set_posts_deleted_at(options, **)
  #   posts = User.find_by(id: options[:model][:id]).posts
  #   posts.each  do |post|
  #     post.deleted_at = Time.now
  #   end
  # end

end