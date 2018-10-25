class User::Create < Trailblazer::Operation

  class Present < Trailblazer::Operation
    step Model(User, :new)
    step Contract::Build( constant: User::Contract::Create )
  end

  step :prepare_params
  step Nested(Present)
  step Contract::Validate(key: :user)
  step Contract::Persist()

  def prepare_params(options, **)
    if uploaded_file = options[:params][:user][:avatar]
      user_name = options[:params][:user][:nickname]
      path = Rails.root.join('public', 'uploads', uploaded_file.original_filename)
      File.open(path, 'wb') do |file|
        file.write(uploaded_file.read)
      end
      UploadAvatar.perform_async(path, user_name)
      options[:params][:user][:avatar] = user_name
    else
      options[:params][:user][:avatar] = ''
    end
  end

end
