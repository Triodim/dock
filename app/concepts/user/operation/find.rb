class User::Find < Trailblazer::Operation

  pass :prepare_params
  step Model(User, :find_by)

  def prepare_params(options, session_id:, **)
    options[:params] = options[:session_id] if session_id.present?
  end
end