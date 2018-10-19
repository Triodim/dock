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
    uploaded_file = options[:params][:user][:avatar]
    path = Rails.root.join('public', 'uploads', uploaded_file.original_filename)
    File.open(path, 'wb') do |file|
      file.write(uploaded_file.read)
    end
    avatar_public_id = Cloudinary::Uploader.upload(path)['public_id']
    options[:params][:user][:avatar] = avatar_public_id
  end

end
