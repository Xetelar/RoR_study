module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(name, validation_type, param = nil)
      @validations ||= []
      @validations << { name: name, type: validation_type, param: param }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        attr_value = instance_variable_get("@#{validation[:name]}")
        send validation[:type], attr_value, validation[:param]
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    private

    def presence(name_value, *_opts)
      raise 'Имя/номер равно nil, или пустой строке' if name_value.to_s.empty?
    end

    def type(name_value, attr_type)
      raise 'Не совпадение класса объекта с заданным классом' unless name_value.is_a?(attr_type)
    end

    def format(name_value, format)
      raise 'Имя/номер не соответствует заданному формату' unless format.match?(name_value.to_s)
    end
  end
end
