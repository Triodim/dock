class User::Block < Trailblazer::Operation

  step :find_user
  step Policy::Pundit(UserPolicy, :destroy?)
  #step Wrap ->(*, &block){ ActiveRecord::Base.transaction do block.call end } {
    step :deactivate
    step :soft_delete_posts
    #raise "My error to rollback transaction"
    #step :return_false
  #}

  def find_user(options, params:, current_user:, **)
    options[:model] = User::Show.(params: params, current_user: current_user)[:model]
  end

  #TODO wrap next two steps with sql transaction
  def deactivate(options, **)
    user = options[:model]
    user.update(active: false)
  end

  def soft_delete_posts(options, **)
    WorkerDeleteUsersPosts.perform_async(options[:model][:id])
  end

  # def return_false(options, **)
  #   return false
  # end

end