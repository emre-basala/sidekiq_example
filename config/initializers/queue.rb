require './lib/queue_wrapper'
QueueWrapper.configure do |config|
  config.worker :rabbitmq
end