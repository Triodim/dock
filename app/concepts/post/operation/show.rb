class Post::Show < Trailblazer::Operation

  pass :prepare_params
  step :validate
  step Model(Post, :find_by)
  step :find_post

  def prepare_params(options, params:, **)
    options[:params] = OpenStruct.new(params) if params.present?
  end

  def validate(options, params:, **)
    options[:validation] = Post::Contract::Show.new(params)
    options[:validation].validate(key: params)
  end


  def find_post(options, **)
    #binding.pry
    options[:model] = ::Post.joins(:category)
                            .where(category_id: options[:model].category_id)
                            .select('posts.*, categories.name as cat_name').first

  end


end