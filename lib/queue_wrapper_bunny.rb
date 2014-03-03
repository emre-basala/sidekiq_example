module QueueWrapperBunny
  def self.configure
  end

  def self.included(base)
    base.extend(ClassMethods)
  end

  def method_missing(name, *args, &block)
    self.class.method_missing(name, *args, block)
  end

  module ClassMethods
   def method_missing(name, *args, &block)
    matches =  /queue_(\w+)/.match name
    if matches
      method_name = matches[1]
      conn = Bunny.new
      conn.start

      ch = conn.create_channel
      q  = ch.queue("debit.02", :auto_delete => true)
      x  = ch.default_exchange

      payload = "#{self}||#{method_name}||#{args.first}"
      x.publish( payload, :routing_key => q.name)

      sleep 1.0
      conn.close
      return
    end
   end

    def queue(queue_name)
    end

    def priority(priority)
    end

  end
end