class ClientNotificationWorker
   include Sidekiq::Worker

   def perform(client_id)
      if (client_id % 5 == 0) && (rand(3) == 0)
        puts "clint is down #{client_id}"
        puts 'retry it later'
        ClientNotificationWorker.perform_in(1.minutes, 5)
      else
        puts "clint is notified #{client_id}"
      end
   end
end