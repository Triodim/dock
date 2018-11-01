class User::Delete < Trailblazer::Operation

  step :find_and_validate
  step Policy::Pundit( UserPolicy, :destroy? )
  step :set_active

  def find_and_validate(options, params:, current_user:, **)
    options[:model] = User::Show.(params: params, current_user: current_user)[:model]
  end

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