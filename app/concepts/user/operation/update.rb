class User::Update < Trailblazer::Operation

  class Present < Trailblazer::Operation
    step Model(User, :find_by)
    step Policy::Pundit(UserPolicy, :update?)
    step Contract::Build(constant: User::Contract::Update)
  end

  step Nested(Present)
  step Contract::Validate(key: :user)
  step Contract::Persist()
  step :ava_is_not_exist, pass_fast: true, Output(:failure) => :upload_image
  success :upload_image

  def ava_is_not_exist(options, **)
    if options[:params][:user][:avatar]
      return false
    else
      options[:ava_error] = "You didn't input ava_file!"
      return true
    end
  end

  def upload_image(options, **)
    result = User::UploadAvatar.(params: options[:params], user_id: options[:model][:id])
    options[:ava_error] = result[:ava_error]
  end

end