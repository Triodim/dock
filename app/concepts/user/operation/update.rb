class User::Update < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(User, :find_by)
    step Contract::Build(constant: User::Contract::Update)
  end

  step Nested(Present)
  step Contract::Validate(key: :user)
  step :save_tmp_file                   # save it locally
  step :validate_avatar                 # this method should do what means it's name
  step Contract::Persist()              # save model with avatar = ''
  step :upload_image_to_cloud

  def save_tmp_file (options, **)
    if uploaded_file = options[:params][:user][:avatar]
      options[:path] = Rails.root.join('public', 'uploads', uploaded_file.original_filename)
      File.open(options[:path], 'wb') do |file|
        file.write(uploaded_file.read)
      end
    end
  end

  def validate_avatar(options, **)
    uploaded_file = options[:params][:user][:avatar]
    if  (uploaded_file.size > 10.megabytes)||(uploaded_file.content_type != "image/jpeg")
      return false
    else
      return true
    end
  end

  def upload_image_to_cloud(options, **)
    UploadAvatar.perform_async(options[:path], options[:model][:id])
  end

end