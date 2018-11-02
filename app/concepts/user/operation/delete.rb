class User::Delete < Trailblazer::Operation

  step :find_and_validate
  step Policy::Pundit( UserPolicy, :destroy? )
  step :set_active
  step :set_posts_deleted_at

  def find_and_validate(options, params:, current_user:, **)
    options[:model] = User::Show.(params: params, current_user: current_user)[:model]
  end

  #TODO wrap with sql transaction
  def set_active(options, **)
    options[:model][:active] = false
    options[:model].save
  end

  #TODO processing in the sidekiq
  def set_posts_deleted_at(options, **)
    #binding.pry
    WorkerDeleteUsersPosts.perform_async(options[:model][:id])
  end

end