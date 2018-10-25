class UploadAvatar
  include Sidekiq::Worker

  def perform(path, user)
    Cloudinary::Uploader.upload(path, :public_id => user)
    File.delete(path)
  end
end
