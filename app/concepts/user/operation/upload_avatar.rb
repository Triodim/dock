class User::UploadAvatar < Trailblazer::Operation

  #step :is_ava_exist
  step :validate_avatar
  step :save_tmp_file
  fail :delete_invalid_ava_file
  step :upload_image_to_cloud

  # def is_ava_exist(options, **)
  #   if options[:params][:user][:avatar]
  #     return true
  #   else
  #     options[:ava_error] = "You didn't input ava_file!"
  #     return false
  #   end
  # end

  def validate_avatar(options, user_id:, **)
    uploaded_file = options[:params][:user][:avatar]
    if  (uploaded_file.size > 5.megabytes)||(uploaded_file.content_type != "image/jpeg")
      options[:ava_error] = "Your ava is too big or not a picture"
      return false
    else
      return true
    end
  end

  def save_tmp_file (options, **)
    uploaded_file = options[:params][:user][:avatar]
    options[:path] = Rails.root.join('public', 'uploads', uploaded_file.original_filename)
    File.open(options[:path], 'wb') do |file|
      file.write(uploaded_file.read)
    end
  end


  def delete_invalid_ava_file(options, **)
    File.delete(options[:path]) if options[:path]
  end

  def upload_image_to_cloud(options, user_id:,**)
    WorkerUploadAvatar.perform_async(options[:path], user_id)
  end

end
