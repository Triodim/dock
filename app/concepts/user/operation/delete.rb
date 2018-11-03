class User::Delete < Trailblazer::Operation

  step :find_and_validate
  step Policy::Pundit(UserPolicy, :destroy?)
  #step Wrap ->(*, &block) { ActiveRecord::Base.transaction do block.call end } {
    step :set_active
    step :set_posts_deleted_at
  #}

  def find_and_validate(options, params:, current_user:, **)
    options[:model] = User::Show.(params: params, current_user: current_user)[:model]
  end

  #TODO wrap two steps with sql transaction
  def set_active(options, **)
    options[:model][:active] = false
    options[:model].save
  end

  def set_posts_deleted_at(options, **)
    WorkerDeleteUsersPosts.perform_async(options[:model][:id])
  end

end