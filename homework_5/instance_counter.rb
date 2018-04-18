module InstanceCounter
  def self.includes(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      @counter
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.counter += 1
    end
  end
end
