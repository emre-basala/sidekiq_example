class O2DebitBillerWorker
  include QueueWrapper

  def self.bill(aa)
    puts 'foo'
  end
end