module QueueWrapperSidekiq
  def self.configure
  end

  def self.included(base)
    base.send(:include, Sidekiq::Worker)
    base.extend(ClassMethods)
  end

  def method_missing(name, *args, &block)
    self.class.method_missing(name, *args, block)
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