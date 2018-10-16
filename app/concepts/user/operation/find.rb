class User::Find < Trailblazer::Operation

  pass :prepare_params
  step :find

  def prepare_params(options, session_id:, **)
    options[:params] = options[:session_id] if session_id.present?
  end
  def find(options, **)
    options[:model] = User.find_by(id: options[:params])
  end

end