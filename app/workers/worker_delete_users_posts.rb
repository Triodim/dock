class WorkerDeleteUsersPosts
  include Sidekiq::Worker

  def perform(id)
    #binding.pry
    Post::SoftDelete.(user_id: id)
  end
end