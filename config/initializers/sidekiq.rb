# read about sidekiq guide
# create worker
# perfom async this worker (add it to any operation and make sure it done)
# read about sidekiq configurations
# create worker with needed code (current task)
# perform async this worker in trb operation

sidekiq_config = { url: ENV['REDIS_URL'] }

Sidekiq.configure_server do |config|
  config.redis = sidekiq_config
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_config
end

# middleware
Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == [ENV['SIDEKIQ_LOGIN'], ENV['SIDEKIQ_PASS']]
end
