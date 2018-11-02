class User::Delete < Trailblazer::Operation

  step :find_and_validate
  step Policy::Pundit( UserPolicy, :destroy? )
  step :set_active
  step :set_posts_deleted_at

  def find_and_validate(options, params:, current_user:, **)
    options[:model] = User::Show.(params: params, current_user: current_user)[:model]
  end

  def set_active(options, **)
    options[:model][:active] = false
    options[:model].save
  end

  def set_posts_deleted_at(options, **)
    posts = User.find_by(id: options[:model][:id]).posts
    posts.each  do |post|
      post.deleted_at = Time.now
      post.save
    end
  end

end