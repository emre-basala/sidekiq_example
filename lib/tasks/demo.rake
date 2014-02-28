namespace :demo do
  desc "runs the demo"
  task :run => :environment do
    O2DebitBiller.queue_bill("postpone")
  end
end

