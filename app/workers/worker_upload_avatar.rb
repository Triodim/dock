class WorkerUploadAvatar
  include Sidekiq::Worker

  def perform(path, user_id)
    #binding.pry path&user_id ok!
    Image::UploadFile.(path: path, user_id: user_id)
  end
end

