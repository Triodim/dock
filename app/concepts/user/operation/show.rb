class User::Show < Trailblazer::Operation

  pass :prepare_params
  step :validate
  step Model(User, :find_by)

  def prepare_params(options, params:, **)
    options[:params] = OpenStruct.new(params) if params.present?
  end

  def validate(options, params:, **)
    options[:validation] = User::Contract::Show.new(params)
    puts "Validation => #{options[:validation].inspect}"
    puts "Params => #{params.inspect}"
    options[:validation].validate(key: params)
  end

end