class Image::UploadFile < Trailblazer::Operation

  step :upload_file_to_cloud
  step :delete_file_from_server
  step :update_user_avatar

  def upload_file_to_cloud(options, path:, **)
    options[:public_id] = Cloudinary::Uploader.upload( path, :folder => Image::UploadPath::CloudinaryPath )['public_id']
  end

  def delete_file_from_server(options, path:, **)
    File.delete(path)
  end

  def update_user_avatar(options, user_id:, **)
    User.update(user_id, avatar: options[:public_id])
  end

end



