module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    @@counter = 0

    def instances
      @@counter
    end

    def register_instance
      @@counter += 1
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.register_instance
    end
  end
end
