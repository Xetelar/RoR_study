module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
    base.counter = 0
  end

  module ClassMethods
    attr_accessor :counter

    def instances
      @counter
    end
  end

  module InstanceMethods
    def register_instance
      self.class.counter += 1
    end
  end
end
