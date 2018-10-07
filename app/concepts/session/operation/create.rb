class Session::Create < Trailblazer::Operation

  #pass :prepare_params
  #step :validate
  step :find_user
  step :authentic
  #binding.pry


  # def prepare_params(options, params:, **)
  #   binding.pry
  #   options[:params] = OpenStruct.new(params) if params.present?
  #
  # end
  #
  # def validate(options, params:, **)
  #   options[:validation] = Session::Contract::Create.new(params)
  #   options[:validation].validate(key: params)
  # end

  def find_user(options, params:, **)
    options[:model] = User.find_by_nickname(params[:nickname])
  end

  def authentic(options, params:, **)
    #binding.pry
    options[:authentic] = options[:model].authenticate(params[:password])
  end
end