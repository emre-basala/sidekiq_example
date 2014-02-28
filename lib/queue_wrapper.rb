module QueueWrapper
  def self.configure
  end

  def self.included(base)
    base.send(:include, Sidekiq::Worker)
    base.extend(ClassMethods)
  end

  #needs to go away with method missing
  def schedule_queue_bill(*args)
    self.class.schedule_queue_bill(*args)
  end

  def perform(method_name, *args)
    self.send(method_name.to_sym, args.first)
  end

  module ClassMethods
   def method_missing(name, *args, &block)
    matches =  /schedule_queue_(\w+)/.match name
    if matches
      method_name = matches[1]
      args.shift
      perform_at(args[0], method_name, *args)
      return
    end

    matches =  /queue_(\w+)/.match name
    if matches
      method_name = matches[1]
      perform_async(method_name, *args)
      return
    end
   end

    def queue(queue_name)
    end

    def priority(priority)
    end

  end
end