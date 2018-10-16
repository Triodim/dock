class Category::Show < Trailblazer::Operation

  pass :prepare_params
  step :validate
  step :model

  def prepare_params(options, params:, **)
    options[:params] = OpenStruct.new(params) if params.present?
  end

  def validate(options, params:, **)
    options[:validation] = Category::Contract::Show.new(params)
    options[:validation].validate(key: params)
  end

  def model(options, params:, **)
    #options[:model] = Category.find_by(id: params[:id])
    options[:model] = ::Category.includes(:user).where(categories: {id: params[:id]}).first
  end

end



