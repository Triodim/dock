class User::Index < Trailblazer::Operation

  pass :prepare_params
  step Model(User, :find_by)
  step Policy::Pundit( UserPolicy, :index? )
  step :show_all

  def prepare_params(options, current_user:, **)
    options[:params] = options[:current_user] if current_user.present?
  end

  def show_all(options, **)
    result = ::User.where(active: true)
    if result.empty?
      return false
    else
      options[:model] = result
    end
  end
end