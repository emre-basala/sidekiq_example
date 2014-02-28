namespace :demo do
  desc "runs the demo"
  task :run => :environment do
     a = O2DebitBiller.queue_bill(:postpone)
  end
end

