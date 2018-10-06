class Category::Show < Trailblazer::Operation

  step Model(Category, :new)
  step Contract::Build(constant: ::Category::Contract::Show)
  step Contract::Validate()
  step :model

  def model(options, params:, **)
    #options[:model] = Category.find_by(id: params[:id])
    options[:model] = ::Category.includes(:user).where(categories: {id: params[:id]}).first
  end
end
