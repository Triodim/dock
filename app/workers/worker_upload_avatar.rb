class WorkerUploadAvatar
  include Sidekiq::Worker

  def perform(path, user_id)
    Image::UploadFile.(path: path, user_id: user_id)
  end
end

