class User::Create < Trailblazer::Operation

# 1) for admins
# block user - active false + delete completely all users posts, in sidekiq job + both actions wrapped as transaction
# activate user - opposite feature

# 2) only admin can creates categories so be sure that this is
# if admin delete category then update all posts in it category with it and assign them to some default category

# 3) send confirmation email to user after registration



  # step Wrap ->(*, &block) { ActiveRecord::Base.transaction do block.call end } {
  #   step Contract::Persist()
  #   step :update_product_owner!
  # }


  class Present < Trailblazer::Operation
    step Model(User, :new)
    step Contract::Build( constant: User::Contract::Create )
  end

  step Nested(Present)
  step Contract::Validate(key: :user)
  step Contract::Persist()
  success :upload_image

  def upload_image(options, **)
   result = Image::Avatar.(params: options[:params], user_id: options[:model][:id])
   options[:ava_error] = result[:ava_error]
  end

end
