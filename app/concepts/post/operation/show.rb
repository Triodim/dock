class Post::Show < Trailblazer::Operation

  pass :prepare_params
  step :validate
  step :find_post

  def prepare_params(options, params:, **)
    options[:params] = OpenStruct.new(params) if params.present?
  end

  def validate(options, params:, **)
    options[:validation] = Post::Contract::Show.new(params)
    options[:validation].validate(key: params)
  end

  def find_post(options, **)
     post = Post.find_by_id(options[:params][:id])
     options[:model] = ::Post.joins(:category, :user)
                            .where(category_id: post.category_id)
                            .select('posts.*, categories.name as cat_name').first
  end


end