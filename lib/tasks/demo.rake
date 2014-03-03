namespace :demo do
  desc "runs the demo"
  task :run => :environment do
    O2DebitBiller.queue_foo("success")
  end

  task :listener => :environment do

  conn = Bunny.new
  conn.start
  while true
    ch = conn.create_channel
    q  = ch.queue("debit.02", :auto_delete => true)
    x  = ch.default_exchange
    q.subscribe do |delivery_info, metadata, payload|
      puts "Received #{payload}"
      parts = payload.split('||')
      class_name = parts[0].constantize
      method_name = parts[1].to_sym
      args = parts[2]
      class_name.new.send(method_name, args)
    end
    sleep 1.0
  end
  conn.close
  end

end

