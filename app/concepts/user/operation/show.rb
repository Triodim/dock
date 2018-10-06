class User::Show < Trailblazer::Operation

  pass :prepare_params
  step :validate
  step Model(User, :find_by)
  #binding.pry

  def prepare_params(options, params:, **)
    options[:params] = OpenStruct.new(params) if params.present?

  end

  def validate(options, params:, **)
    options[:validation] = User::Contract::Show.new(params)
    options[:validation].validate(key: params)
  end

end