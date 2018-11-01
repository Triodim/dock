class User::Update < Trailblazer::Operation

  class Present < Trailblazer::Operation
    step Model(User, :find_by)
    step Policy::Pundit(UserPolicy, :update?)
    step Contract::Build(constant: User::Contract::Update)
  end

  step Nested(Present)
  step Contract::Validate(key: :user)
  step Contract::Persist()
  success :upload_image

  def upload_image(options, **)
    result = User::UploadAvatar.(params: options[:params], user_id: options[:model][:id])
    options[:ava_error] = result[:ava_error]
  end

end