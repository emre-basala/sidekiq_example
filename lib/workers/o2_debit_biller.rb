class O2DebitBiller
  include QueueWrapper
  queue  'debit:02'
  priority :high

   def bill(result_will_be)
      # doing something and now we have the result to decide on something
      result = result_will_be
      puts result
      if result == :postpone
        puts 'postpone billing etc because client is down or something'
        self.queue_bill(15.minutes, :will_retry)
      else
        if result == :success
          puts 'done billing is success'
        elsif result == :will_retry #like phone number is not longer opt in etc
          # self.retry = self.retry +1
          puts 'retry billing in 1 minute!'
          self.class.queue_bill(1.minutes, amount, :retry_exhausted)
        elsif result == :retry_exhausted # insufficent funds
          puts 'retry exhausted! giving up!'
        end
      end
   end
end