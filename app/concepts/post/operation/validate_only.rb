# class Post::ValidateOnly < Trailblazer::Operation
#   step :prepare_params
#   step :build
#   step :validate
#
#   def prepare_params(ctx, params:, **)
#     ctx[:params] = OpenStruct.new(params) if params.present?
#   end
#
#   def build(options, params:, **)
#     options[:validation] = Post::Contract::Show.new(params)
#   end
#
#   def validate(options, **)
#     options[:validation].validate
#   end
# end

