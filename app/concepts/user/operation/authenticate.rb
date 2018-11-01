class User::Authenticate < Trailblazer::Operation

  pass :prepare_params
  step :validate_input_params
  step :find_user
  step :authenticate


  def prepare_params(options, params:, **)
    options[:params] = OpenStruct.new(params) if params.present?
  end

  def validate_input_params(options, params:, **)
    options[:validation] = User::Contract::New.new(params)
    options[:validation].validate(key: params)
  end

  def find_user(options, params:, **)
    options[:model] = User.where(nickname: params[:nickname], active: true).first
  end

  def authenticate(options, params:, **)
    options[:authentic] = options[:model].authenticate(params[:password])
  end
end