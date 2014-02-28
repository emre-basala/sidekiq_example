module QueueWrapper
  def self.configure
  end

  def self.included(base)
    base.send(:include, Sidekiq::Worker)
    base.extend(ClassMethods)
  end

  module ClassMethods
     def method_missing(name, *args, &block)
      matches =  /queue_(\w+)/.match name
      if matches
        method_name = matches[1]
        self.instance_eval do
           define_method "perform" do |*arg|
            self.send(method_name.to_sym, arg)
           end
        end
        perform_async(args)
      end
     end

    # def queue_bill(*args)
    #   perform_async(args)
    # end

    def queue(queue_name)
    end

    def priority(priority)
    end
  end
end