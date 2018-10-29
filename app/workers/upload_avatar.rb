class UploadAvatar
  include Sidekiq::Worker

  def perform(path, user_id)
    public_id = Cloudinary::Uploader.upload( path, :folder => "dock/avatars/" )['public_id']
    user = User.find_by(id: user_id)
    user.avatar = public_id
    user.save
    File.delete(path)
  end
end
